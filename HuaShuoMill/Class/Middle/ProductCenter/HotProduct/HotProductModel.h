//
//  HomeCollectionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "id": "2",
 "category_id": "0",
 "title": "\u5927\u5c4fiPhone\u8fdf\u5230 \u5e94\u7528\u5206\u8fa8\u7387\u9002\u914d\u662f\u5173\u952e",
 "link": "http:\/\/118.123.16.62\/tinycms\/index.php\/goods\/detail?goodsId=78544",
 "description": "<p><span style=\"color: rgb(37, 37, 37); font-family: \u5b8b\u4f53, sans-
 "img": "http:\/\/gi3.mlist.alicdn.com\/bao\/uploaded\/i3\/T10prLXhFgXXcus0DX_114607.jpg_b.jpg"
 
 */

@interface HotProductModel : NSObject

@property(nonatomic,assign)long long hotProductID;
@property(nonatomic,assign)long long category_id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *descri;
@property(nonatomic,copy)NSString *img;


- (instancetype)initWithDic:(NSDictionary *)dic;


@end
