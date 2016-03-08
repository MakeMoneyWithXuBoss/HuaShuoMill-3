//
//  HomeCollectionCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "CategoriesInfoCell.h"

@interface CategoriesInfoCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@end

@implementation CategoriesInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"CategoriesInfoCell";
    CategoriesInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CategoriesInfoCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setHomeCollectionModel:(CategoriesInfoModel *)homeCollectionModel
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
