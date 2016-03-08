//
//  SettingArrowItem.h
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingItem.h"
#import <UIKit/UIKit.h>

@interface SettingArrowItem : SettingItem

//跳转到下一个控制器
@property(nonatomic,strong)UIViewController *destVcObject;

@property(nonatomic,assign)Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcObject:(UIViewController *)destVcObject;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;


@end
