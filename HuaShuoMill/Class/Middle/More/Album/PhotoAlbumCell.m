//
//  PhotoAlbumCell.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/19.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "PhotoAlbumCell.h"

@interface PhotoAlbumCell()



@end

@implementation PhotoAlbumCell

- (void)setPhotoAlbumModel:(PhotoAlbumModel *)photoAlbumModel
{
    _photoAlbumModel = photoAlbumModel;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_photoAlbumModel.thumbnail]] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
