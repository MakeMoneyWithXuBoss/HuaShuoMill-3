//
//  UIViewController+MarginBarButtonItem.m
//  DoctorAssistant
//
//  Created by ios_ysj on 14/11/30.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "UIViewController+MarginBarButtonItem.h"

@implementation UIViewController (MarginBarButtonItem)


#pragma mark - 设置左右边的的间隔
- (void)setLeftBarButtonItem:(UIBarButtonItem *)item
{
    [self setLeftBarButtonItem:item animated:NO];
}
- (void)setRightBarButtonItem:(UIBarButtonItem *)item
{
    [self setRightBarButtonItem:item animated:NO];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftItem animated:(BOOL)animated
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    UIBarButtonItem *marginItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -12;
        
        if (leftItem)
        {
            [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftItem,marginItem]];
        }
        else
        {
            [self.navigationItem setLeftBarButtonItems:@[negativeSeperator]];
        }
        
    }
    else
    {
        [self.navigationItem setLeftBarButtonItems:@[leftItem] animated:animated];
    }
    
}


- (void)setRightBarButtonItem:(UIBarButtonItem *)rightItem animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -12;
        
        if (rightItem)
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightItem]];
        }
        else
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator]];
        }
        
    }
    else
    {
        [self.navigationItem setLeftBarButtonItems:@[rightItem] animated:animated];
    }
    
}


@end
