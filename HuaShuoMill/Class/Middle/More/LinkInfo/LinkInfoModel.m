//
//  HomeCollectionModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "LinkInfoModel.h"

@implementation LinkInfoModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.category_id = [[dic objectForKey:@"category_id"] longLongValue];
        self.descri = [dic objectForKey:@"description"];
        self.guid = [[dic objectForKey:@"guid"] longLongValue];
        self.link_id = [[dic objectForKey:@"id"] longLongValue];
        self.pub_date = [dic objectForKey:@"pub_date"];
        self.title = [dic objectForKey:@"title"];
        self.url = [dic objectForKey:@"url"];
    }
    return self;
}


@end
