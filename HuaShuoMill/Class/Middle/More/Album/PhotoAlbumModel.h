//
//  PhotoAlbumModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/19.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "id": "45",
 "guid": "45",
 "caption": "\u597d\u6f02\u4eae\u54e6",
 "thumbnail": "http:\/\/app.shouhubao365.com\/mm.jpg",
 "category_id": "0",
 "allowSave": "1",
 "hidden": "1",
 "cropped": "",
 "fullsize": "http:\/\/app.shouhubao365.com\/mm.jpg"
 */

@interface PhotoAlbumModel : NSObject

@property(nonatomic,assign)NSInteger id;
@property(nonatomic,copy)NSString *guid;
@property(nonatomic,copy)NSString *caption;
@property(nonatomic,copy)NSString *thumbnail;
@property(nonatomic,copy)NSString *category_id;
@property(nonatomic,copy)NSString *allowSave;
@property(nonatomic,copy)NSString *hidden;
@property(nonatomic,copy)NSString *cropped;
@property(nonatomic,copy)NSString *fullsize;

@end
