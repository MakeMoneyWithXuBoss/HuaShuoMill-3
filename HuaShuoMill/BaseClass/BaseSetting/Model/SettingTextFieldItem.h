//
//  SettingTextFieldItem.h
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/17.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingItem.h"
typedef void(^SettingTextFieldItemOperation)(NSString *text);

typedef enum : NSUInteger {
    TextFieldDirectionRigth = 0,
    TextFieldDirectionLeft = 1,
} TextFieldDirection;

@interface SettingTextFieldItem : SettingItem

@property(nonatomic,assign)TextFieldDirection textFieldDirection;


@property(nonatomic,copy)NSString *textTitle;
@property(nonatomic,copy)NSString *placeholderText;

@property(nonatomic,copy)SettingTextFieldItemOperation textFieldItemOperation;

+ (instancetype)itemWithTitle:(NSString *)title textFieldTitle:(NSString *)textTitle;

+ (instancetype)itemWithTitle:(NSString *)title textFieldTitle:(NSString *)textTitle placeholderText:(NSString *)placeholderText;
+ (instancetype)itemWithTitle:(NSString *)title textFieldTitle:(NSString *)textTitle placeholderText:(NSString *)placeholderText textFieldDirection:(TextFieldDirection)textFieldDirection;

@end
