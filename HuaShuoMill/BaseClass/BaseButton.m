//
//  BaseButton.m
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/3/26.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    
   CGSize titleLableSize = [self.titleLabel.text sizeWithFont:self.font constrainedToSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    
    self.width = (titleLableSize.width > self.width) ? titleLableSize.width+20 : self.width;
}

@end
