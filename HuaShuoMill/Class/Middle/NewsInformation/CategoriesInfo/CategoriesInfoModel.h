//
//  HomeCollectionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "category_id" = 1;
 description = "\U5bf9\U4e8e\U97f3\U4e50\U53d1\U9a9a\U53cb\U6765\U8bf4\Uff0c\U4ed6\U4eec\U8046\U542c\U7684\U4e0d\U4ec5\U4ec5\U53ea\U662f\U65cb\U5f8b\Uff0c\U97f3\U8d28\Uff0c\U58f0\U573a\Uff0c\U4e09\U9891\U7684\U8868\U73b0\U529b";
 fullpost = "\U5168\U6587";
 guid = 1;
 id = 1;
 img = "http://gi3.mlist.alicdn.com/bao/uploaded/i3/T10prLXhFgXXcus0DX_114607.jpg_b.jpg";
 isTop = 1;
 link = "ext://news";
 "pub_date" = "";
 subtitle = "";
 timeago = "2 days ago";
 title = "PC\U9996\U9009\U88c5\U5907\U534e\U7855\U8001\U864e\U5361\U9876\U7ea7\U58f0\U97f3\U6765\U88ad";
 "total_comments" = 23;
 type = official;
 
 */

@interface CategoriesInfoModel : NSObject

@property(nonatomic,assign)long long category_id;
@property(nonatomic,copy)NSString *descr;
@property(nonatomic,copy)NSString *fullpost;
@property(nonatomic,assign)long long guid;
@property(nonatomic,assign)long long collectionId;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,assign)long long isTop;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *pub_date;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *timeago;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)long long total_comments;
@property(nonatomic,copy)NSString *type;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
