//
//  Common.m
//  XianHuoTong
//
//  Created by XuhuiMing on 15/4/20.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "Common.h"

@implementation Common

#pragma mark - 判断字符串是否为空
BOOL TTIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}

+  (void)showAlertViewDelegate:(id)delegate  title:(NSString*)title message:(NSString*)message
{
    UIAlertView *alertDialog = [[UIAlertView alloc]
                                initWithTitle: title
                                message:message
                                delegate:delegate
                                cancelButtonTitle: NSLocalizedString(@"确定", @"确定")
                                otherButtonTitles: nil];
    [alertDialog show];
}


+ (void)showText:(NSString *)showText
{
    if (TTIsStringWithAnyText(showText)) {
        
        //[[iToast makeText:showText] show];
        [SVProgressHUD showErrorWithStatus:showText];
    }
}

+ (void)showCollectionSuccessString:(BOOL)collection
{
    if (collection) {
        //[[iToast makeText:[NSString stringWithFormat:@"%@",cancelcollectionSuccessString]] show];
    }else{
        //[[iToast makeText:[NSString stringWithFormat:@"%@",collectionSuccessString]] show];
    }
}


+ (BOOL)isNull:(id)object
{
    if ([object isKindOfClass:[NSNumber class]]) {
        object = [NSString stringWithFormat:@"%@",object];
    }
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (object==nil)
    {
        return YES;
    }else if ([object isEqualToString:@"<null>"]){
        return YES;
    }else if ([object isEqualToString:@"null"])
    {
        return YES;
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return YES;
    }
    else if ([object isEqualToString:@""]){
        return NO;
    }
    return NO;
}

//判断文件是否存在
BOOL TTisExistsFileWithPath(NSString *checkFile) {
    return [[NSFileManager defaultManager] fileExistsAtPath:checkFile];
}


@end
