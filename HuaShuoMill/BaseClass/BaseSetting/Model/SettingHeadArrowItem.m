//
//  SettingImageArrowItem.m
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/18.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingHeadArrowItem.h"

@implementation SettingHeadArrowItem

+ (instancetype)itemWithTitle:(NSString *)title headImage:(UIImage *)headImage
{
    SettingHeadArrowItem *item = [self itemWithTitle:title];
    item.headImage = headImage;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title setHeadImageWithURL:(NSURL *)urlString placeholderImage:image
{
    SettingHeadArrowItem *item = [self itemWithTitle:title headImage:image];
    item.urlString = urlString;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title setHeadImageWithURL:(NSURL *)urlString placeholderImage:image isDisplayArrow:(BOOL)isDisplayArrow
{
    SettingHeadArrowItem *item = [self itemWithTitle:title setHeadImageWithURL:urlString placeholderImage:image];
    item.isDisplayArrow = isDisplayArrow;
    
    return item;
    
}

@end
