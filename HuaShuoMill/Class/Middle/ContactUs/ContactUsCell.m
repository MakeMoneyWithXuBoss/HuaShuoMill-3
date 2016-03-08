//
//  HomeCollectionCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ContactUsCell.h"

@interface ContactUsCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descripLabelTop;


@end

@implementation ContactUsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"ContactUsCell";
    ContactUsCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactUsCell" owner:self options:nil] lastObject];
    }
    return cell;
}


- (void)setContactUsModel:(ContactUsModel *)contactUsModel
{
    _contactUsModel = contactUsModel;
       
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_contactUsModel.image]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"contact_%@",_contactUsModel.type]]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_contactUsModel.title];
    self.descripLabel.text = [NSString stringWithFormat:@"%@",_contactUsModel.descri];
    
    if ([_contactUsModel.type isEqualToString:@"link"]) {
        self.descripLabel.text = [NSString stringWithFormat:@"%@",_contactUsModel.link
                                  ];
    }
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.contactUsModel.type isEqualToString:@"location"]) {
        //self.descripLabelTop.constant = 40;
    }
}

@end
