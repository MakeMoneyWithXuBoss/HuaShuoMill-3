//
//  BrandCollectionViewCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/14.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "VideoLiveCell.h"

@interface VideoLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation VideoLiveCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setVideoLiveModel:(VideoLiveModel *)videoLiveModel
{
    _videoLiveModel = videoLiveModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_videoLiveModel.img]] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",_videoLiveModel.title];
}

@end
