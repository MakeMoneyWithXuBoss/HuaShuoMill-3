//
//  SettingDetailItem.h
//  MyDoctor
//
//  Created by ios_ysj on 15/1/23.
//  Copyright (c) 2015年 doctorplusone. All rights reserved.
//

#import "SettingArrowItem.h"

@interface SettingDetailArrowItem : SettingArrowItem

@property(nonatomic,copy)NSString *detailTitle;

@property(nonatomic,copy)NSString *consulteTitle;//咨询价格
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle consulteTitle:(NSString *)consulteTitle;
//图文咨询 电话咨询
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailTitle:(NSString *)detailTitle destVcClass:(Class)destVcClass;

+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailTitle:(NSString *)detailTitle destVcObject:(UIViewController *)destVcObject;

//图文咨询 电话咨询
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailTitle:(NSString *)detailTitle;

@end
