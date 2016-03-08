//
//  ProductCenterInfoCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "QueryServiceCenterCell.h"

@interface QueryServiceCenterCell()

@end

@implementation QueryServiceCenterCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"QueryServiceCenterCell";
    QueryServiceCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"QueryServiceCenterCell" owner:self options:nil] lastObject];
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
