//
//  UIBarButtonItem+CustomButtonItem.m
//  DoctorAssistant
//
//  Created by ios_ysj on 14/11/24.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "UIBarButtonItem+CustomButtonItem.h"

@implementation UIBarButtonItem (CustomButtonItem)

/**
 *  快速创建一个显示图片的item
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateSelected];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [button setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];


    //button.titleLabel.textColor = [UIColor orangeColor];
    button.frame = CGRectMake(0, 0, 60, 30);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
