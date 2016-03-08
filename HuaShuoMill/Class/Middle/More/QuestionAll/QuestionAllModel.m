//
//  HomeCollectionModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "QuestionAllModel.h"
#import "ReplyQuestionModel.h"

@implementation QuestionAllModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.question_id = [[dic objectForKey:@"id"] longLongValue];
        self.content = [dic objectForKey:@"content"];
        self.pub_date = [dic objectForKey:@"pub_date"];
        self.type = [dic objectForKey:@"type"];
        self.reply = [dic objectForKey:@"reply"];
    }
    return self;
}


- (void)setReply:(NSMutableDictionary *)reply
{
    _reply = reply;
    
    if ([_reply isKindOfClass:[NSDictionary class]] && _reply.allKeys.count > 0) {
        
        ReplyQuestionModel *replyQuestionModel = [[ReplyQuestionModel alloc] init];
        [replyQuestionModel setValuesForKeysWithDictionary:_reply];
    }
}

@end
