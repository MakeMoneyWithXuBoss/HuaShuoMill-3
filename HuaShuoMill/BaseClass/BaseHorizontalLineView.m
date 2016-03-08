//
//  BaseLineView.m
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/3/28.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "BaseHorizontalLineView.h"

#define HorizontalLineViewbackgroundColor RGBColor(215,215,215)//     所有分割线颜色：#d7d7d7      RGB:215 215 215



@implementation BaseHorizontalLineView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.height = 0.5;
    
    self.backgroundColor = HorizontalLineViewbackgroundColor;
}

@end
