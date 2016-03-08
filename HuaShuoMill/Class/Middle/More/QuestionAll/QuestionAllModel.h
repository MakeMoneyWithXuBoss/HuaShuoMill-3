//
//  HomeCollectionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "id": "1",
 "content": "\u4e3a\u4ec0\u4e48\u6885\u96e8\u5b63\u8282\u4e0b\u96e8\u6bd4\u8f83\u591a",
 "pub_date": "2013-01-01 12:12",
 "type": "question",
 "reply": [{
 "content": "\u5f00\u5f00\u5fc3\u5fc3",
 "name": "\u5f20\u4e09",
 "pub_date": "2013-01-01 12:12"
 }, {
 "content": "\u5403\u7684\u592a\u591a",
 "name": "\u5f20\u4e09",
 "pub_date": "2013-01-01 12:12"
 }]
 
 */

@interface QuestionAllModel : NSObject

@property(nonatomic,assign)long long question_id;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *pub_date;
@property(nonatomic,copy)NSString *type;

@property(nonatomic,strong)NSMutableDictionary *reply;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
