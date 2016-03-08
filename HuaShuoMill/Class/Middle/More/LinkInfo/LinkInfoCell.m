//
//  ProductCenterInfoCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "LinkInfoCell.h"

@interface LinkInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LinkInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"LinkInfoCell";
    LinkInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LinkInfoCell" owner:self options:nil] lastObject];
    }
    return cell;
}


- (void)setLinkInfoModel:(LinkInfoModel *)linkInfoModel
{
    _linkInfoModel = linkInfoModel;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_linkInfoModel.title];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
