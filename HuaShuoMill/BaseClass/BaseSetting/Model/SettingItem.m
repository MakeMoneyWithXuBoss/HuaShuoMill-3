//
//  SettingItem.m
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle
{
    SettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    item.subtitle = subTitle;
    return item;
}


+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    SettingItem *item = [self item];
    item.title = title;
    item.subtitle = subTitle;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle isDisplayArrow:(BOOL)isDisplayArrow
{
    SettingItem *item = [self itemWithTitle:title subTitle:subTitle];
    item.isDisplayArrow = isDisplayArrow;
    
    return item;
}



+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}
+(instancetype)item
{
    SettingItem *item = [[self alloc] init];
    item.isDisplayArrow = YES;
    
    return item;
}


@end
