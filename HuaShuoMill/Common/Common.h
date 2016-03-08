//
//  Common.h
//  XianHuoTong
//
//  Created by XuhuiMing on 15/4/20.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject<UIAlertViewDelegate>

BOOL TTIsStringWithAnyText(id object);

BOOL TTisExistsFileWithPath(NSString *checkFile);

+  (void)showAlertViewDelegate:(id)delegate  title:(NSString*)title message:(NSString*)message;

+ (void)showText:(NSString *)showText;

+ (void)showCollectionSuccessString:(BOOL)collection;


//对象是否为null
+ (BOOL)isNull:(id)object;


@end
