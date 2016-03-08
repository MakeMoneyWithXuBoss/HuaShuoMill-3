//
//  UserInfoHeadCellTableViewCell.m
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/4/15.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "UserInfoHeadCell.h"

@implementation UserInfoHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"NewsCell";
    UserInfoHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoHeadCell" owner:self options:nil] lastObject];
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
