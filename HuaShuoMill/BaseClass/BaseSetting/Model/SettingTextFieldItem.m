//
//  SettingTextFieldItem.m
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/17.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingTextFieldItem.h"

@implementation SettingTextFieldItem


/**
 *  点击单元格输入文本框
 */
+ (instancetype)itemWithTitle:(NSString *)title textFieldTitle:(NSString *)textTitle
{
    SettingTextFieldItem *item = [self itemWithTitle:title];
    item.textTitle = textTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title textFieldTitle:(NSString *)textTitle placeholderText:(NSString *)placeholderText
{
    SettingTextFieldItem *item = [self itemWithTitle:title];
    item.textTitle = textTitle;
    item.placeholderText = placeholderText;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title textFieldTitle:(NSString *)textTitle placeholderText:(NSString *)placeholderText textFieldDirection:(TextFieldDirection)textFieldDirection
{
    SettingTextFieldItem *item = [self itemWithTitle:title textFieldTitle:textTitle placeholderText:placeholderText];
    item.textFieldDirection = textFieldDirection;
    return item;
    
}

@end
