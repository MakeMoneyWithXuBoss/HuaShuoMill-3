//
//  HotProductCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/16.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "HotProductCell.h"
#import "RTLabel.h"

@interface HotProductCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property (weak, nonatomic) IBOutlet RTLabel *descriRTLabel;
@property (weak, nonatomic) IBOutlet UIWebView *descriWebView;




@end

@implementation HotProductCell

- (void)awakeFromNib {
    // Initialization code
    
    self.descriRTLabel.backgroundColor = [UIColor whiteColor];
}

- (void)setHotProductModel:(HotProductModel *)hotProductModel
{
    _hotProductModel = hotProductModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_hotProductModel.img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@",_hotProductModel.title];
    [self.descriWebView loadHTMLString:_hotProductModel.descri baseURL:nil];
    //self.descriRTLabel.text = [NSString stringWithFormat:@"%@",_hotProductModel.descri];
    
}



@end
