//
//  SettingLabelArrowItem.h
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/18.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingArrowItem.h"

@interface SettingLabelArrowItem : SettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle destVcClass:(Class)destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;


@end
