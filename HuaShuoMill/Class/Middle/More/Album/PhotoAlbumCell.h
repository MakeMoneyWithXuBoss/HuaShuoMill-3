//
//  PhotoAlbumCell.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/19.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoAlbumModel.h"

@interface PhotoAlbumCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;


@property(nonatomic,strong)PhotoAlbumModel *photoAlbumModel;

@end
