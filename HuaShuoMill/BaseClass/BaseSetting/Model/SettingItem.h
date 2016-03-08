//
//  SettingItem.h
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SettingItemOperation)();

@interface SettingItem : NSObject

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;

@property(nonatomic,copy)NSString *highlightIcon;

@property(nonatomic,copy)NSString *badgeValue;

//是否展示右边箭头
@property(nonatomic,getter=isDisplayArrow) BOOL isDisplayArrow;

@property(nonatomic,copy)SettingItemOperation operation;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle;
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;


//是否显示右边箭头
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle isDisplayArrow:(BOOL)isDisplayArrow;


+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+(instancetype)itemWithTitle:(NSString *)title;
+(instancetype)item;

@end
