//
//  ReplyQuestionModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/19.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "content": "\u5403\u7684\u592a\u591a",
 "name": "\u5f20\u4e09",
 "pub_date": "2013-01-01 12:12"
 */

@interface ReplyQuestionModel : NSObject

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *pub_date;

@end
