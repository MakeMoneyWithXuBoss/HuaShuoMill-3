//
//  SettingImageArrowItem.h
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/18.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingItem.h"
#import <UIKit/UIKit.h>

@interface SettingHeadArrowItem : SettingItem

@property(nonatomic,strong)UIImage *headImage;

@property(nonatomic,strong)NSURL *urlString;

+ (instancetype)itemWithTitle:(NSString *)title headImage:(UIImage *)headImage;

+ (instancetype)itemWithTitle:(NSString *)title setHeadImageWithURL:(NSURL *)urlString placeholderImage:image;
+ (instancetype)itemWithTitle:(NSString *)title setHeadImageWithURL:(NSURL *)urlString placeholderImage:image isDisplayArrow:(BOOL)isDisplayArrow;


@end
