//
//  BaseTableViewCell.h
//  DoctorAssistant
//
//  Created by ios_ysj on 14/11/30.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;

@interface BaseSettingTableViewCell : UITableViewCell

@property(nonatomic,strong)SettingItem *settingItem;
@property(nonatomic,strong)NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
