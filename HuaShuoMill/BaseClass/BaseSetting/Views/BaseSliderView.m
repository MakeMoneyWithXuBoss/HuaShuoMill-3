//
//  BaseSliderView.m
//  PartimeJobInfo
//
//  Created by ios_ysj on 15/3/13.
//  Copyright (c) 2015年 ___HuiMing Xu___. All rights reserved.
//

#import "BaseSliderView.h"

@implementation BaseSliderView

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    //CGFloat sliderViewH = bounds.size.height;
        
    bounds.size.height = 0.5;
    
    return bounds;
}

@end
