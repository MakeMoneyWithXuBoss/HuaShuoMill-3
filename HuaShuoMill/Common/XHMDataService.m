//
//  BaseManager.m
//  
//
//  Created by ios_ysj on 14/11/25.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "XHMDataService.h"
#import "OpenUDID.h"


#define HTTPMETHOD_GET  @"GET"
#define HTTPMETHOD_POST  @"POST"

@implementation XHMDataService
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)urlstring
                                    params:(NSMutableDictionary *)params
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoadHandle)block
                                errorblock:(ErrorLoadHandle)erroblock
{
   return [self requestWithURL:urlstring params:params isShowLoading:NO httpMethod:httpMethod block:block errorblock:erroblock];
}

//网络请求
+ (AFHTTPRequestOperation *)requestWithURL:(NSString *)urlstring
                                    params:(NSMutableDictionary *)params
                             isShowLoading:(BOOL)isLoading
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoadHandle)block
                                errorblock:(ErrorLoadHandle)erroblock{
    
    if (isLoading) {
        //显示正在加载框
        [SVProgressHUD showWithStatus:@"正在加载..."];
    }
    
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    //1.拼接URL
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@",urlstring];
    
    /*
     //2.获取认证的授权令牌
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
     
     //取得令牌字符串
     NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
     if (accessToken.length == 0) {
     return nil;
     } else {
     //将令牌添加到请求参数中
     [params setObject:accessToken forKey:@"access_token"];
     }
     */
    
    //3.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
    AFHTTPRequestOperation *operation = nil;
    
#pragma mark - 公共数据
    NSString *key = (__bridge NSString *)kCFBundleVersionKey;
    // 1.当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //[params setObject:API_Root_appusername forKey:@"appuser"];
    //[params setObject:API_Root_appkey forKey:@"appkey"];
    //[params setObject:API_Root_apptype forKey:@"client"];

    [params setObject:[NSString stringWithFormat:@"%@",currentVersion] forKey:@"version"];
    [params setObject:[OpenUDID value] forKey:@"token"];
    
    if ([httpMethod isEqualToString:@"GET"]) {
        
        //4.发送GET请求
        operation = [manager GET:url
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             
                             if (isLoading) {
                                 //隐藏加载框
                                 [SVProgressHUD dismiss];
                             }
                             
                             if (block != nil) {
                                 block(responseObject);
                             }
                             
                            // APPLog(@"%@",responseObject);
                            // NSString *status = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
                            // 
                            //
                            // 
                            // if ([status isEqualToString:@"1"]) {
                            //     if (block != nil) {
                            //         block(responseObject);
                            //     }
                            // }else{//网络请求失败
                            //     
                            //     if (![Common isNull:[responseObject objectForKey:@"message"]]) {
                            //         NSString *message = [responseObject objectForKey:@"message"];
                            //         
                            //         
                            //         if (TTIsStringWithAnyText(message)) {
                            //             [SVProgressHUD showWithStatus:message];
                            //         }else{
                            //             [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                            //         }
                            //     }else{
                            //         [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                            //     }
                            //     
                            //     //失败了给一个回调
                            //     NSError *error = [[NSError alloc] init];
                            //     erroblock(error);
     
                             //}
                             
                            
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             
                             if (isLoading) {
                                 //隐藏加载框
                                                                  [SVProgressHUD dismiss];

                             }
                             
                             [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                             

                             erroblock(error);
                             APPLog(@"请求网络失败：%@",error);
                         }];
        
    }else if([httpMethod isEqualToString:@"POST"]){
        //4.发送POST请求
        
        BOOL isFile = NO;
        for (NSString *key in params) {
            id value = params[key];
            //判断请求参数是否是文件数据
            if ([value isKindOfClass:[NSData class]]) {
                isFile = YES;
                break;
            }
        }
        
        if (!isFile) {
            //如果参数中没有文件，使用以下方法发送网络请求
            [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                if (isLoading) {
                    //隐藏加载框
                                                     [SVProgressHUD dismiss];

                }
                
                
                
                if (block != nil) {
                    block(responseObject);
                }
                
                APPLog(@"%@",operation.request.allHTTPHeaderFields);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                if (isLoading) {
                    //隐藏加载框
                                                     [SVProgressHUD dismiss];

                }
                
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                
                erroblock(error);
                APPLog(@"请求网络失败：%@",error);
            }];
        } else {
            
            //如果参数中带有文件，使用如下POST方法请求网络
            operation = [manager POST:url
                           parameters:params
            constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                         {
                             for (NSString *key in params) {
                                 id value = params[key];
                                 
                                 //判断请求参数是否是文件数据
                                 if ([value isKindOfClass:[NSData class]]) {
                                     
                                     //将文件数据添加到formData中
                                     [formData appendPartWithFileData:value
                                                                 name:key
                                                             fileName:key
                                                             mimeType:@"image/jpeg"];
                                     
                                 }
                             }
                         }
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
                                  if (isLoading) {
                                      //隐藏加载框
                                                                       [SVProgressHUD dismiss];

                                  }
                                  
                                  APPLog(@"%@",responseObject);
                                  
                                  NSString *status = [responseObject objectForKey:@"status"];
                                  if ([status isEqualToString:@"1"]) {
                                      if (block != nil) {
                                          block(responseObject);
                                      }
                                  }else{//网络请求失败
                                      
                                      if (![Common isNull:[responseObject objectForKey:@"message"]]) {
                                          NSString *message = [responseObject objectForKey:@"message"];
                                          if (TTIsStringWithAnyText(message)) {
                                              [SVProgressHUD showWithStatus:message];
                                          }else{
                                              [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                                          }
                                      }else{
                                          [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                                      }
                                      
                                      
                                      //失败了给一个回调
                                      NSError *error = [[NSError alloc] init];
                                      erroblock(error);
                                      
                                  }
                                  
                                //if (block != nil) {
                                //  block(responseObject);
                                //}
                                  
                                  APPLog(@"response:%@",operation.response.allHeaderFields);
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                                  if (isLoading) {
                                      //隐藏加载框
                                                                       [SVProgressHUD dismiss];

                                  }
                                  
                                  [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                                  
                                  APPLog(@"请求网络失败：%@",error);
                                  erroblock(error);
                              }];
        }
    }
    
    //5.设置返回数据的解析方式
    operation.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    return operation;
}


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
                errorBlock:(ErrorLoadHandle)failure
{
    
    [self postRequestWithURL:urlstring params:params isShowLoading:NO successBlock:success errorBlock:failure];
}

+ (void)postRequestWithURL:(NSString *)urlstring
                    params:(NSMutableDictionary *)params                              isShowLoading:(BOOL)isLoading
              successBlock:(CompletionLoadHandle)success
                errorBlock:(ErrorLoadHandle)failure
{
    
    [self requestWithURL:urlstring params:params isShowLoading:isLoading
              httpMethod:HTTPMETHOD_POST
                   block:^(id result) {
                       if (success) {
                           success(result);
                       }
                       
                   } errorblock:^(NSError *error) {
                       
                       if (failure) {
                           failure(error);
                       }
                   }];
}

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
                isShowLoading:(BOOL)isLoading
                 successBlock:(CompletionLoadHandle)success
                   errorBlock:(ErrorLoadHandle)failure
{
    
    
    if (isLoading) {
        //显示正在加载框
        [MBProgressHUD showMessage:@"正在发表..."];
    }
    
    //1.请求参数
    if (params == nil) {
        params = [NSMutableDictionary dictionary];
    }
    
    //2.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //3.发送请求
    [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (FormData *singleFormData in formDataArray) {
            [formData appendPartWithFileData:singleFormData.data name:singleFormData.name fileName:singleFormData.filename mimeType:singleFormData.mimeType];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (isLoading) {
            //隐藏加载框
                                             [SVProgressHUD dismiss];

        }

        APPLog(@"%@",responseObject);
        
        NSString *errCode = [responseObject objectForKey:@"errCode"];
        if ([errCode isEqualToString:@"0"]) {
            if (success != nil) {
                success(responseObject);
            }
        }else{//网络请求失败
            
            if (![Common isNull:[responseObject objectForKey:@"msg"]]) {
                NSString *msg = [responseObject objectForKey:@"msg"];
                if (TTIsStringWithAnyText(msg)) {
                    [SVProgressHUD showWithStatus:msg];
                }else{
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Server error,Try again later.",@"")];
            }
            
            
            
        }



        //if (success) {
        //    success(responseObject);
        //}
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (isLoading) {
            //隐藏加载框
                                             [SVProgressHUD dismiss];

        }
        if (failure) {
            
            failure(error);
        }
    }];

}

+ (void)postUploadFileWithURL:(NSString *)urlstring
                formDataArray:(NSArray *)formDataArray
                       params:(NSMutableDictionary *)params
                 successBlock:(CompletionLoadHandle)success
                   errorBlock:(ErrorLoadHandle)failure
{
    [self postUploadFileWithURL:urlstring formDataArray:formDataArray params:params isShowLoading:NO successBlock:success errorBlock:failure];
    
    //    //1.请求参数
    //    if (params == nil) {
    //        params = [NSMutableDictionary dictionary];
    //    }
    //    
    //    //2.创建请求管理对象
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    
    //    
    //    //3.发送请求
    //    [manager POST:urlstring parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        
    //        for (FormData *singleFormData in formDataArray) {
    //            [formData appendPartWithFileData:singleFormData.data name:singleFormData.name fileName:singleFormData.filename mimeType:singleFormData.mimeType];
    //        }
    //        
    //        
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        
    //        
    //        if (success) {
    //            success(responseObject);
    //        }
    //        
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        
    //        APPLog(@"%@",error);
    //        
    //        if (failure) {
    //            
    //            failure(error);
    //        }
    //    }];
    
}

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
               errorBlock:(ErrorLoadHandle)failure
{
    [self requestWithURL:urlstring params:params isShowLoading:NO httpMethod:HTTPMETHOD_GET block:success errorblock:failure];
    
    /*
     [self requestWithURL:urlstring params:params
     isShowLoading:(BOOL)NO
     httpMethod:HTTPMETHOD_GET
     block:^(id result) {
     
     if (success) {
     success(result);
     }
     
     } errorblock:^(NSError *error) {
     
     
     if (failure) {
     failure(error);
     }
     }];
    
     */
}

/**加入一个加载框**/
+ (void)getRequestWithURL:(NSString *)urlstring
                   params:(NSMutableDictionary *)params
                   isShowLoading:(BOOL)isLoading
             successBlock:(CompletionLoadHandle)success
               errorBlock:(ErrorLoadHandle)failure
{
 
    [self requestWithURL:urlstring params:params
           isShowLoading:(BOOL)isLoading
              httpMethod:HTTPMETHOD_GET
                   block:^(id result) {

                       if (success) {
                           success(result);
                       }
                       
                   } errorblock:^(NSError *error) {
                       
                       
                       if (failure) {
                           failure(error);
                       }
                   }];
}


+ (void)downFileOptionWithURL:(NSString *)aUrlstring
                 saveFillPath:(NSString *)aSavefilePath
                     fileName:(NSString *)aFileName
                 progressBlock:(DownFileProgressHandle)progress
                successBlock:(CompletionLoadHandle)success
                   errorBlock:(ErrorLoadHandle)failure
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //检查本地文件是否已存在
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavefilePath, aFileName];
    
    //检查附件是否存在
    //if ([fileManager fileExistsAtPath:fileName]) {
    //    
    //   //NSData *audioData = [NSData dataWithContentsOfFile:fileName];
    //}else{
        //创建附件存储目录
        if (![fileManager fileExistsAtPath:aSavefilePath]) {
            [fileManager createDirectoryAtPath:aSavefilePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        //下载附件
        NSURL *url = [[NSURL alloc] initWithString:aUrlstring];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        //下载进度控制
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            APPLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
            if (progress) {
                progress((float)totalBytesRead/totalBytesExpectedToRead);
            }
         }];
    
        //已完成下载
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
           // NSData *audioData = [NSData dataWithContentsOfFile:fileName];
            //设置下载数据到res字典对象中并用代理返回下载数据NSData
            
            if (success != nil) {
                success(responseObject);
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            //下载失败
            if (failure) {
                failure(error);
            }
        }];
        
        [operation start];
//    }

}


@end
