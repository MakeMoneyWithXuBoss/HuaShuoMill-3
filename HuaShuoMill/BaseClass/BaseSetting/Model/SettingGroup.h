//
//  SettingGroup.h
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
/**
 *  头部标题
 */
@property(nonatomic,copy)NSString *headerTitle;
/**
 *  尾部标题
 */
@property(nonatomic,copy)NSString *footerTitle;
/**
 *  存放着这组所有行的模型数据（）
 */
@property(nonatomic,strong)NSArray *sectionItemArray;

+ (instancetype)group;


@end
