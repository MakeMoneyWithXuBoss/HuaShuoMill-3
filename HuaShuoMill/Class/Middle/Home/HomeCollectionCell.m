//
//  HomeCollectionCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "HomeCollectionCell.h"

@interface HomeCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@end

@implementation HomeCollectionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"HomeCollectionCell";
    HomeCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCollectionCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setHomeCollectionModel:(HomeCollectionModel *)homeCollectionModel
{
    _homeCollectionModel = homeCollectionModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_homeCollectionModel.img]] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_homeCollectionModel.title];
    
    self.descripLabel.text = [NSString stringWithFormat:@"%@",_homeCollectionModel.descr];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
