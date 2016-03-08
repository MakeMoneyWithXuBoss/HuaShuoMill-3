//
//  BasePushSubViewController.h
//  YunYi_iOS_2.0
//
//  Created by XuhuiMing on 15/4/17.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "BaseViewController.h"

@protocol NavigationSubViewControllerDelegate <NSObject>

@optional
- (void)pushSubViewController:(UIViewController *)viewController;

- (void)superViewControllerendEditing:(BOOL)force;

@end

@interface BasePushSubViewController : BaseViewController

@property(nonatomic,assign)id<NavigationSubViewControllerDelegate> delegate;

@end
