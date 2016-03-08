//
//  UserInfoHeadCellTableViewCell.h
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/4/15.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"

@interface UserInfoHeadCell : UITableViewCell

@property(nonatomic,strong)SettingItem *settingItem;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
