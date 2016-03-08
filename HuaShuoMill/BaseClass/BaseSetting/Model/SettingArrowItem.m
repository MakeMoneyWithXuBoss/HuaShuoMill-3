//
//  SettingArrowItem.m
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    
    SettingArrowItem *item = [self itemWithIcon:icon title:title subTitle:subTitle];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcObject:(UIViewController *)destVcObject
{
    SettingArrowItem *item = [self itemWithIcon:nil title:title subTitle:subTitle];
    item.destVcObject = destVcObject;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    SettingArrowItem *item = [self itemWithIcon:nil title:title subTitle:subTitle];
    item.destVcClass = destVcClass;
    return item;
}

/**
 *  点击单元格cell需要跳转的控制器
 */
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    
    SettingArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
    
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}

@end
