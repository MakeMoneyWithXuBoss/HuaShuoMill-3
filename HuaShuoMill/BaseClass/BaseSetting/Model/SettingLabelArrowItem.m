//
//  SettingLabelArrowItem.m
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/18.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingLabelArrowItem.h"

@implementation SettingLabelArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass
{
    
    SettingLabelArrowItem *item = [self itemWithIcon:icon title:title subTitle:subTitle];
    item.destVcClass = destVcClass;
    return item;
}

/**
 *  点击单元格cell需要跳转的控制器
 */
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    SettingLabelArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}

@end
