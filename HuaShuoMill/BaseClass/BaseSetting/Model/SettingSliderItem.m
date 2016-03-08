//
//  SettingProgressItem.m
//  PartimeJobInfo
//
//  Created by ios_ysj on 15/3/13.
//  Copyright (c) 2015年 ___HuiMing Xu___. All rights reserved.
//

#import "SettingSliderItem.h"

@implementation SettingSliderItem

+ (instancetype)itemWithTitle:(NSString *)title progressViwValue:(double )progressValue
{
    SettingSliderItem *item = [self itemWithTitle:title];
    item.progressValue = progressValue;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title progressViwValue:(double )progressValue thumbTintColor:(UIColor *)thumbTintColor
{
    SettingSliderItem *item = [self itemWithTitle:title progressViwValue:progressValue];
    item.thumbTintColor = thumbTintColor;
    return item;
}

@end
