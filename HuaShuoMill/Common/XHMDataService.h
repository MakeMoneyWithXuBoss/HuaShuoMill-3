//
//  BaseManager.h
//  
//
//  Created by ios_ysj on 14/11/25.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^CompletionLoadHandle)(id result);
typedef void(^ErrorLoadHandle)(NSError *error);


typedef void(^DownFileProgressHandle)(CGFloat progress);


@interface XHMDataService : NSObject

//网络请求
/**
 *  发送一个请求
 *
 *  @param urlstring  请求路径
 *  @param params     请求参数
 *  @param httpMethod 请求方式
 *  @param block      请求成功后的回调
 *  @param erroblock  请求失败后的回调
 *
 *  @return 
 */
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)urlstring
                                    params:(NSMutableDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoadHandle)block
                                errorblock:(ErrorLoadHandle)erroblock;

/*加入加载框*/
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)urlstring
                                    params:(NSMutableDictionary *)params
                             isShowLoading:(BOOL)isLoading
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoadHandle)block
                                errorblock:(ErrorLoadHandle)erroblock;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postRequestWithURL:(NSString *)urlstring
                    params:(NSMutableDictionary *)params
                     successBlock:(CompletionLoadHandle)success
                errorBlock:(ErrorLoadHandle)failure;

/*是否显示加载框*/
+ (void)postRequestWithURL:(NSString *)urlstring
                    params:(NSMutableDictionary *)params                              isShowLoading:(BOOL)isLoading
              successBlock:(CompletionLoadHandle)success
                errorBlock:(ErrorLoadHandle)failure;


/*下载文件*/
//+ (void)downFileOptionWithURL:(NSString *)urlstring
//                 saveFillPath:(NSString *)filePath
//                     fileName:(NSString *)fileName
//                successBlock:(CompletionLoadHandle)success
//                   errorBlock:(ErrorLoadHandle)failure;

+ (void)downFileOptionWithURL:(NSString *)aUrlstring
                 saveFillPath:(NSString *)aSavefilePath
                     fileName:(NSString *)aFileName
                 progressBlock:(DownFileProgressHandle)progress
                 successBlock:(CompletionLoadHandle)success
                   errorBlock:(ErrorLoadHandle)failure;


/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postUploadFileWithURL:(NSString *)urlstring
                formDataArray:(NSArray *)formDataArray
                    params:(NSMutableDictionary *)params
              successBlock:(CompletionLoadHandle)success
                errorBlock:(ErrorLoadHandle)failure;
+ (void)postUploadFileWithURL:(NSString *)urlstring
                formDataArray:(NSArray *)formDataArray
                       params:(NSMutableDictionary *)params
                isShowLoading:(BOOL)isLoading
                 successBlock:(CompletionLoadHandle)success
                   errorBlock:(ErrorLoadHandle)failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getRequestWithURL:(NSString *)urlstring
                    params:(NSMutableDictionary *)params
              successBlock:(CompletionLoadHandle)success
                errorBlock:(ErrorLoadHandle)failure;

/*是否显示加载框*/
+ (void)getRequestWithURL:(NSString *)urlstring
                   params:(NSMutableDictionary *)params
            isShowLoading:(BOOL)isLoading
             successBlock:(CompletionLoadHandle)success
               errorBlock:(ErrorLoadHandle)failure;



@end

/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
