//
//  SettingSwitchItem.h
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingItem.h"

@interface SettingSwitchItem : SettingItem

//开关是否开启
@property(nonatomic,getter=isOpen) BOOL isOpen;

+(instancetype)itemWithTitle:(NSString *)title isOpen:(BOOL)isOpen;

@end
