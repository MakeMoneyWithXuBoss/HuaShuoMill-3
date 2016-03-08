//
//  HomeCollectionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 description = "";
 id = 1;
 img = "http://gi3.mlist.alicdn.com/bao/uploaded/i3/T10prLXhFgXXcus0DX_114607.jpg_b.jpg";
 link = "http://118.123.16.62/love.3gp";
 "pub_date" = "";
 title = "\U516c\U53f8\U5e74\U4f1a";
 
 */

@interface VideoLiveModel : NSObject

@property(nonatomic,copy)NSString *descr;
@property(nonatomic,assign)NSInteger videoId;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *pub_date;
@property(nonatomic,copy)NSString *title;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
