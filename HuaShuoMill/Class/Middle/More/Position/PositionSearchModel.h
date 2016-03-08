//
//  HomeCollectionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 address = "";
 "category_id" = 3;
 description = "";
 guid = 234;
 id = 123;
 lat = "";
 lon = "";
 name = "\U5357\U5c71\U79d1\U6280\U56ed";
 phone = "";
 "pub_date" = "";
 "store_hours" = "";
 url = "http://www.baidu.com";
 
 */

@interface PositionSearchModel : NSObject

@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)long long category_id;
@property(nonatomic,copy)NSString *descr;
@property(nonatomic,assign)long long guid;
@property(nonatomic,assign)long long positionId;
@property(nonatomic,copy)NSString *lat;
@property(nonatomic,copy)NSString *lon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *pub_date;
@property(nonatomic,copy)NSString *store_hours;
@property(nonatomic,copy)NSString *url;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
