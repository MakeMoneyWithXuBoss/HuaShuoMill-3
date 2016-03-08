//
//  SettingProgressItem.h
//  PartimeJobInfo
//
//  Created by ios_ysj on 15/3/13.
//  Copyright (c) 2015年 ___HuiMing Xu___. All rights reserved.
//

#import "SettingItem.h"
#import <UIKit/UIKit.h>

@interface SettingSliderItem : SettingItem


@property(nonatomic,assign)double progressValue;
@property(nonatomic,strong)UIColor *thumbTintColor;

+ (instancetype)itemWithTitle:(NSString *)title progressViwValue:(double )progressValue;
+ (instancetype)itemWithTitle:(NSString *)title progressViwValue:(double )progressValue thumbTintColor:(UIColor *)thumbTintColor;

@end
