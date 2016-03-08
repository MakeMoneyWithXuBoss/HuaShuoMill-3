//
//  BrandCollectionViewCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/14.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ProductCollectionCell.h"

@interface ProductCollectionCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ProductCollectionCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setProductBrandModel:(ProductCollectionModel *)productBrandModel
{
    _productBrandModel = productBrandModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_productBrandModel.img]] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_productBrandModel.title];
}

@end
