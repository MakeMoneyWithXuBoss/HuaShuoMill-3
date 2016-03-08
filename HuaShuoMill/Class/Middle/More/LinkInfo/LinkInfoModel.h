//
//  HomeCollectionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "category_id" = 3;
 description = "";
 guid = 234;
 id = 123;
 "pub_date" = "";
 title = "\U7ef4\U4fee\U72b6\U6001\U67e5\U8be2";
 url = "http://www.baidu.com";
 */

@interface LinkInfoModel : NSObject

@property(nonatomic,assign)long long category_id;
@property(nonatomic,copy)NSString *descri;
@property(nonatomic,assign)long long guid;
@property(nonatomic,assign)long long link_id;
@property(nonatomic,copy)NSString *pub_date;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *url;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
