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
 description = "400-6000-898";
 guid = 234;
 id = 123;
 image = "";
 link = "";
 "pub_date" = "";
 title = "\U5ba2\U670d\U70ed\U7ebf";
 type = phone;
 
 */


@interface ContactUsModel : NSObject

@property(nonatomic,assign)long long category_id;
@property(nonatomic,copy)NSString *descri;
@property(nonatomic,assign)long long guid;
@property(nonatomic,assign)long long contactUsId;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *link;
@property(nonatomic,copy)NSString *pub_date;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end
