//
//  DDHttpService.m
//  DingDingCore
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "BSHttpService.h"
#import "NSDictionary+NullReplacement.h"
#import "CommonUtils.h"

static BSHttpService * instance = nil;

@interface BSHttpService()
@property (strong, nonatomic) NSMutableArray *opValues;
@property (strong, nonatomic) NSMutableDictionary *defaultHeaderDic;
@end

@implementation BSHttpService

+ (BSHttpService*)getInstance
{
	@synchronized(self) {
		if (instance == nil)
        {
			instance = [[BSHttpService alloc] init];
		}
	}
	return instance;
}

NSString* const GET = @"GET";
NSString* const POST = @"POST";

- (id)init{
    self = [super init];
    if (self){
        _opValues = [[NSMutableArray alloc] init];
        _removeWindowLoading = NO;
        _removeCurrentViewLoading = NO;
    }
    return self;
}

- (NSMutableDictionary *)defaultHeaderDic{
    if (!_defaultHeaderDic) {
        _defaultHeaderDic = [NSMutableDictionary dictionary];
    }
    
    [_defaultHeaderDic setValue:@"" forKey:@"Authorization: Token"];
    
    return _defaultHeaderDic;
}

- (NSMutableDictionary *)getBodyByBaseParam:(NSDictionary *)body{
    NSMutableDictionary *bodyParams = body ? [NSMutableDictionary dictionaryWithDictionary:body] : [NSMutableDictionary dictionary];
    
    return bodyParams;
}

- (void)addNetworkOperationToOpValues:(MKNetworkOperation *)op {
    [self.opValues addObject:op];
}

- (void)removeNetworkOperationWithUniqueId:(NSString*)uniqueId
{
    MKNetworkOperation* op = [self findNetworkOperationWithUniqueId:uniqueId];
    if(op != nil)
    {
        [self.opValues removeObject:op];
    }
}

- (MKNetworkOperation *)findNetworkOperationWithUniqueId:(NSString*)uniqueId
{
    for(MKNetworkOperation* op in self.opValues)
    {
        if([op.uniqueIdentifier isEqualToString:uniqueId])
        {
            return op;
        }
    }
    return nil;
}


/**
 *  Get请求
 *
 *  @param url       请求url
 *  @param headerDic 请求http头
 *  @param response  返回结果
 */
- (void)sendGetWithURL:(NSString*)url httpHeader:(NSDictionary*)headerDic response:(BSResponse)response
{
    NSLog(@"url is %@",url);

    [self showLoadingView];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url
                                                          params:nil
                                                      httpMethod:GET];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    
    
    if (self.defaultHeaderDic.count != 0) {
        [op addHeaders:self.defaultHeaderDic];
    }

    if(headerDic) {
        [op addHeaders:headerDic];
    }
    
    [self addNetworkOperationToOpValues:op];
    @weakify(self)
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        @strongify(self)
        if([completedOperation responseData]) {
            id dc = [completedOperation responseJSON];
            NSLog(@"server response: %@", dc);
            if([dc isKindOfClass:[NSDictionary class]])
            {
                if ([[dc dictionaryByReplacingNullsWithBlanks][@"Code"] integerValue] == 14) {//Token过期 清楚本地数据 重新登录
                    
                    [self hiddenLoadingView];
                    [LPUnitily showToastWithText:[dc dictionaryByReplacingNullsWithBlanks][@"Msg"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStateChanged object:nil];
                } else {
                    response([dc dictionaryByReplacingNullsWithBlanks],nil);
                    [self hiddenLoadingView];
                }
            }else if ([dc isKindOfClass:[NSArray class]]){
                response([dc arrayByReplacingNullsWithBlanks], nil);
                [self hiddenLoadingView];
            }
            else
            {
                [self hiddenLoadingView];
                [LPUnitily showToastWithText:@"Json格式错误~"];
                response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
            }
        }
        else
        {
            [LPUnitily showToastWithText:@"接口返回数据为空~"];
            response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
        }
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
    }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        @strongify(self)
        NSLog(@"get error: %@", error);
        [self hiddenLoadingView];
        [LPUnitily showToastWithText:error.localizedDescription];
        response(nil, [BSError errorWithNSError:error]);
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
    }];
    
    [engine enqueueOperation:op];
}

/**
 *  Post请求
 *
 *  @param url       请求url
 *  @param body      请求body
 *  @param headerDic 请求http头
 *  @param response  返回结果
 */
- (void)sendPostWithURL:(NSString*)url body:(NSDictionary*)body httpHeader:(NSDictionary*)headerDic response:(BSResponse)response
{
    NSLog(@"url is %@",url);
    
    [self showLoadingView];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url
                                                          params:[[self getBodyByBaseParam:body] mutableCopy]
                                                      httpMethod:POST];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    
    if (self.defaultHeaderDic.count != 0) {
        [op addHeaders:self.defaultHeaderDic];
    }

    if(headerDic) {
        [op addHeaders:headerDic];
    }
    
    [self addNetworkOperationToOpValues:op];
    @weakify(self)
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        @strongify(self)
        if([completedOperation responseData]) {
            id  dc = [completedOperation responseJSON];
            
            // 打印返回
            [CommonUtils printLogUrl:[NSURL URLWithString:[completedOperation url]] parameters:[completedOperation readonlyPostDictionary] finalResponseObject:dc];
            
            if([dc isKindOfClass:[NSDictionary class]])
            {
                if ([[dc dictionaryByReplacingNullsWithBlanks][@"Code"] integerValue] == 14) {//Token过期 清楚本地数据 重新登录
                    [self hiddenLoadingView];
                    [LPUnitily showToastWithText:[dc dictionaryByReplacingNullsWithBlanks][@"Msg"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStateChanged object:nil];
                } else {
                    response([dc dictionaryByReplacingNullsWithBlanks],nil);
                    [self hiddenLoadingView];
                }
            }
            else if([dc isKindOfClass:[NSArray class]]){ //依赖外部接口 可能是array
                response([dc arrayByReplacingNullsWithBlanks],nil);
                [self hiddenLoadingView];
            }
            else
            {
                [self hiddenLoadingView];
                [LPUnitily showToastWithText:@"Json格式错误~"];
                response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
            }
        }
        else
        {
            [self hiddenLoadingView];
            [LPUnitily showToastWithText:@"接口返回数据为空~"];
            response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
        }
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"post error: %@", error);
        [self hiddenLoadingView];
        [LPUnitily showToastWithText:error.localizedDescription];
        response(nil, [BSError errorWithNSError:error]);
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
    }];
    
    [engine enqueueOperation:op];
}

/**
 * 上传文件
 *
 *  @param contentData      文件二进制内容
 *  @param url              地址
 *  @param response         结果返回
 *  @param esProgress       上传进度
 */
- (void)uploadFile:(NSData *)contentData url:(NSString *)url httpHeader:(NSDictionary*)headerDic response:(BSResponse)response progress:(BSProgress )bsProgress{
    NSLog(@"url is %@",url);
    

//    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:[NSURL URLWithString:url].host customHeaderFields:nil];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url
                                                     params:nil
                                                 httpMethod:@"POST"];
    
    if (self.defaultHeaderDic.count != 0) {
        [op addHeaders:self.defaultHeaderDic];
    }
    
    if(headerDic) {
        [op addHeaders:headerDic];
    }
    
    [op addData:contentData forKey:@"file" mimeType:@"image/jpg" fileName:@"abc.jpg"];
    
    // setFreezable uploads your images after connection is restored!
    [op setFreezable:YES];
    
    [op onUploadProgressChanged:^(double progress) {
        //上传进度
        
        NSNumber *fileSize = [op.cacheHeaders valueForKey:@"Content-Length"];

        NSLog(@"upload progress: %.2f、upload size: %@", progress*100.0,fileSize);

        if (bsProgress) {
            bsProgress(progress,[fileSize doubleValue]*progress,[fileSize doubleValue]);
        }
    }];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        id dc = [completedOperation responseJSON];
        // 打印返回
        [CommonUtils printLogUrl:[NSURL URLWithString:[completedOperation url]] parameters:[completedOperation readonlyPostDictionary] finalResponseObject:dc];

        if([dc isKindOfClass:[NSDictionary class]])
        {
            response([dc dictionaryByReplacingNullsWithBlanks],nil);
        }
        else if([dc isKindOfClass:[NSArray class]]){ //依赖外部接口 可能是array
            response([dc arrayByReplacingNullsWithBlanks],nil);
        }
        else
        {
            response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"upload file error: %@", error);
        response(nil, [BSError errorWithNSError:error]);
    }];
    
    [engine enqueueOperation:op];
}

/**
 * 下载文件
 *
 * @param url                   地址
 * @param responseFile          完成回调
 * @param esProgress            下载进度
 */
- (void)downloadFileWithUrl:(NSString *)url responseFile:(BSResponseFile)responseFile progress:(BSProgress)bsProgress{
    NSString *filePath = [[[LPSystemManager sharedInstance] offlineFilePath] stringByAppendingPathComponent:[url md5]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        responseFile(filePath,nil);
    }else{
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:[NSURL URLWithString:url].host customHeaderFields:nil];
        MKNetworkOperation *op = [engine operationWithURLString:url
                                                         params:nil
                                                     httpMethod:@"GET"];
        
        [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath
                                                                append:YES]];
        [op onDownloadProgressChanged:^(double progress) {
            //下载进度
            NSLog(@"download progress: %.2f", progress*100.0);
            
            NSNumber *fileSize = [op.cacheHeaders valueForKey:@"Content-Length"];
            bsProgress(progress,[fileSize doubleValue]*progress,[fileSize doubleValue]);
        }];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSLog(@"download file finished!");

        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"download file error: %@", error);
            responseFile(nil, [BSError errorWithNSError:error]);
        }];

        [engine enqueueOperation:op];
    }
}

/**
 * 批量上传文件从数组
 * @param url 地址
 * @param files 文件data数组
 * @param response 返回结果
 */
- (void)uploadFiles:(NSArray*)files url:(NSString *)url response:(BSResponse)response{
    dispatch_group_t group = dispatch_group_create();
    
    __block NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for(NSData *data in files)
    {
        dispatch_group_enter(group);
        [self uploadFile:data url:url httpHeader:nil response:^(id dict, BSError *error) {
            [dataArray addObject:data];

            dispatch_group_leave(group);
        } progress:^(double progress, double didSize, double fileSize) {
            
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 通知主线程
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:dataArray, @"Datas", nil];
        response(dict,nil);
    });
}


//deleat请求
- (void)sendDeleatWithURL:(NSString*)url httpHeader:(NSDictionary*)headerDic response:(BSResponse)response
{
    NSLog(@"url is %@",url);
    
    [self showLoadingView];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url
                                                     params:nil
                                                 httpMethod:@"DELETE"];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    
    
    if (self.defaultHeaderDic.count != 0) {
        [op addHeaders:self.defaultHeaderDic];
    }
    
    if(headerDic) {
        [op addHeaders:headerDic];
    }
    
    [self addNetworkOperationToOpValues:op];
    @weakify(self)
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        @strongify(self)
        if([completedOperation responseData]) {
            id dc = [completedOperation responseJSON];
            NSLog(@"server response: %@", dc);
            if([dc isKindOfClass:[NSDictionary class]])
            {
                if ([[dc dictionaryByReplacingNullsWithBlanks][@"Code"] integerValue] == 14) {//Token过期 清楚本地数据 重新登录
                    
                    [self hiddenLoadingView];
                    [LPUnitily showToastWithText:[dc dictionaryByReplacingNullsWithBlanks][@"Msg"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStateChanged object:nil];
                } else {
                    response([dc dictionaryByReplacingNullsWithBlanks],nil);
                    [self hiddenLoadingView];
                }
            }else if ([dc isKindOfClass:[NSArray class]]){
                response([dc arrayByReplacingNullsWithBlanks], nil);
                [self hiddenLoadingView];
            }
            else
            {
                [self hiddenLoadingView];
                [LPUnitily showToastWithText:@"Json格式错误~"];
                response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
            }
        }
        else
        {
            [LPUnitily showToastWithText:@"接口返回数据为空~"];
            response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
        }
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
    }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        @strongify(self)
        NSLog(@"get error: %@", error);
        [self hiddenLoadingView];
        [LPUnitily showToastWithText:error.localizedDescription];
        response(nil, [BSError errorWithNSError:error]);
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
    }];
    
    [engine enqueueOperation:op];
}

//put请求
- (void)sendPutWithURL:(NSString*)url body:(NSDictionary*)body httpHeader:(NSDictionary*)headerDic response:(BSResponse)response
{
    NSLog(@"url is %@",url);
    
    [self showLoadingView];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation *op = [engine operationWithURLString:url
                                                     params:[[self getBodyByBaseParam:body] mutableCopy]
                                                 httpMethod:@"PUT"];
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    
    if (self.defaultHeaderDic.count != 0) {
        [op addHeaders:self.defaultHeaderDic];
    }
    
    if(headerDic) {
        [op addHeaders:headerDic];
    }
    
    [self addNetworkOperationToOpValues:op];
    @weakify(self)
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        @strongify(self)
        if([completedOperation responseData]) {
            id  dc = [completedOperation responseJSON];
            
            // 打印返回
            [CommonUtils printLogUrl:[NSURL URLWithString:[completedOperation url]] parameters:[completedOperation readonlyPostDictionary] finalResponseObject:dc];
            
            if([dc isKindOfClass:[NSDictionary class]])
            {
                if ([[dc dictionaryByReplacingNullsWithBlanks][@"Code"] integerValue] == 14) {//Token过期 清楚本地数据 重新登录
                    
                    [self hiddenLoadingView];
                    [LPUnitily showToastWithText:[dc dictionaryByReplacingNullsWithBlanks][@"Msg"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStateChanged object:nil];
                } else {
                    response([dc dictionaryByReplacingNullsWithBlanks],nil);
                    [self hiddenLoadingView];
                }
            }
            else if([dc isKindOfClass:[NSArray class]]){ //依赖外部接口 可能是array
                response([dc arrayByReplacingNullsWithBlanks],nil);
                [self hiddenLoadingView];
            }
            else
            {
                [self hiddenLoadingView];
                [LPUnitily showToastWithText:@"Json格式错误~"];
                response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
            }
        }
        else
        {
            [self hiddenLoadingView];
            [LPUnitily showToastWithText:@"接口返回数据为空~"];
            response(nil, [BSError errorWithDomain:@"LotterySelect" code:99999 userInfo:[NSDictionary dictionary]]);
        }
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"post error: %@", error);
        [self hiddenLoadingView];
        [LPUnitily showToastWithText:error.localizedDescription];
        response(nil, [BSError errorWithNSError:error]);
        
        [self removeNetworkOperationWithUniqueId:completedOperation.uniqueIdentifier];
    }];
    
    [engine enqueueOperation:op];
}


- (void)cancelAll
{
    for (MKNetworkOperation *op in self.opValues) {
        [op cancel];
    }
    
    [LPUnitily removeHUDToCurrentView];
}

- (void)showLoadingView{
    if (self.hiddenLoading) {
        self.hiddenLoading = NO;
    }else if (self.showWindowLoading){
        [LPUnitily addHUDToSystemWindowWithString:@"加载中..."];
        self.showWindowLoading = NO;
        self.removeWindowLoading = YES;
    }else {
        [LPUnitily addHUDToCurrentViewWithString:@"加载中..."];
        self.removeCurrentViewLoading = YES;
    }
}

- (void)hiddenLoadingView {
    if (self.removeCurrentViewLoading) {
        [LPUnitily removeHUDToCurrentView];
        self.removeCurrentViewLoading = NO;
    }
    if (self.removeWindowLoading) {
        [LPUnitily removeHUDToSystemWindow];
        self.removeWindowLoading = NO;
    }
}

@end
