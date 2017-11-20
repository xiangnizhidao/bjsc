//
//  DDHttpService.h
//  DingDingCore
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ServicesDefine.h"

#define BS_HttpService [BSHttpService getInstance]

@interface BSHttpService : NSObject

@property (nonatomic, assign) BOOL hiddenLoading;
@property (nonatomic, assign) BOOL removeWindowLoading;
@property (nonatomic, assign) BOOL removeCurrentViewLoading;

@property (nonatomic, assign) BOOL showWindowLoading;

/**
 * 单例
 */
+ (BSHttpService*)getInstance;


/**
 *  Get请求
 *
 *  @param url       请求url
 *  @param headerDic 请求http头
 *  @param response  返回结果
 */
- (void)sendGetWithURL:(NSString*)url httpHeader:(NSDictionary*)headerDic response:(BSResponse)response;

/**
 *  Post请求
 *
 *  @param url       请求url
 *  @param body      请求body
 *  @param headerDic 请求http头
 *  @param response  返回结果
 */
- (void)sendPostWithURL:(NSString*)url body:(NSDictionary*)body httpHeader:(NSDictionary*)headerDic response:(BSResponse)response;

/**
 * 上传文件
 *
 *  @param contentData      文件二进制内容
 *  @param url              地址
 *  @param response         结果返回
 *  @param esProgress       上传进度
 */
- (void)uploadFile:(NSData *)contentData url:(NSString *)url httpHeader:(NSDictionary*)headerDic response:(BSResponse)response progress:(BSProgress)bsProgress;

/**
 * 下载文件
 *
 * @param url                   地址
 * @param responseFile          完成回调
 * @param esProgress            下载进度
 */
- (void)downloadFileWithUrl:(NSString *)url responseFile:(BSResponseFile)responseFile progress:(BSProgress)bsProgress;

/**
 * 批量上传文件从数组
 * @param url 地址
 * @param files 文件data数组
 * @param response 返回结果
 */
- (void)uploadFiles:(NSArray*)files url:(NSString *)url response:(BSResponse)response;

//deleat请求
- (void)sendDeleatWithURL:(NSString*)url httpHeader:(NSDictionary*)headerDic response:(BSResponse)response;
//put请求
- (void)sendPutWithURL:(NSString*)url body:(NSDictionary*)body httpHeader:(NSDictionary*)headerDic response:(BSResponse)response;

/*取消请求 不包括上传文件 下载文件请求*/
- (void)cancelAll;

@end
