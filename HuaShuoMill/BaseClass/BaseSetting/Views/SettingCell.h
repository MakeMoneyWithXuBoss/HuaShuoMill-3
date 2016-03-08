//
//  SettingCell.h
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSettingTableViewCell.h"

@class SettingItem;
@interface SettingCell : UITableViewCell

@property(nonatomic,strong)SettingItem *settingItem;
@property(nonatomic,strong)NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
