//
//  SettingSwitchItem.m
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingSwitchItem.h"

@implementation SettingSwitchItem


+(instancetype)itemWithTitle:(NSString *)title isOpen:(BOOL)isOpen
{
    SettingSwitchItem *item = [self itemWithIcon:nil title:title];
   
    item.isOpen = isOpen;
    return item;
}

@end
