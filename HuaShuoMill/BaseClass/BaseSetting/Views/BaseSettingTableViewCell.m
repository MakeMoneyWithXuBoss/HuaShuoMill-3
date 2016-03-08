//
//  BaseTableViewCell.m
//  DoctorAssistant
//
//  Created by ios_ysj on 14/11/30.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "BaseSettingTableViewCell.h"

@implementation BaseSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"BaseSettingTableViewCell";
    BaseSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[BaseSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        
    }
    
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
