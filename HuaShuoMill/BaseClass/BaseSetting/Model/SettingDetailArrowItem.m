//
//  SettingDetailItem.m
//  MyDoctor
//
//  Created by ios_ysj on 15/1/23.
//  Copyright (c) 2015年 doctorplusone. All rights reserved.
//

#import "SettingDetailArrowItem.h"

@implementation SettingDetailArrowItem

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle consulteTitle:(NSString *)consulteTitle
{
    SettingDetailArrowItem *item = [self itemWithIcon:icon title:title subTitle:subTitle];
    item.consulteTitle = consulteTitle;
    return item;
}

//图文咨询 电话咨询
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailTitle:(NSString *)detailTitle destVcClass:(Class)destVcClass;
{
    SettingDetailArrowItem *item = [self itemWithTitle:title subTitle:subTitle detailTitle:detailTitle];
    item.destVcClass = destVcClass;
    return item;
}

//给一个已经创建好的对象给我
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailTitle:(NSString *)detailTitle destVcObject:(UIViewController *)destVcObject;
{
    SettingDetailArrowItem *item = [self itemWithTitle:title subTitle:subTitle detailTitle:detailTitle];
    item.destVcObject = destVcObject;
    return item;
}

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailTitle:(NSString *)detailTitle
{
    SettingDetailArrowItem *item = [self item];
    item.title = title;
    item.subtitle = subTitle;
    item.detailTitle = detailTitle;
    return item;
}

@end
