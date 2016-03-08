//
//  UIViewController+MarginBarButtonItem.h
//  DoctorAssistant
//
//  Created by ios_ysj on 14/11/30.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MarginBarButtonItem)

/**
 * 左右边间隙以及缩小触摸范围
 */
- (void)setLeftBarButtonItem:(UIBarButtonItem *)item;
- (void)setRightBarButtonItem:(UIBarButtonItem *)item;
- (void)setLeftBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
- (void)setRightBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;

@end
