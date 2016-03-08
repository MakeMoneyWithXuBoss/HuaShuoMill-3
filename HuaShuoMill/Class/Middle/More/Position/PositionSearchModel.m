//
//  HomeCollectionModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "PositionSearchModel.h"

@implementation PositionSearchModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.descr = [dic objectForKey:@"address"];
        self.category_id = [[dic objectForKey:@"category_id"] longLongValue];
        self.descr = [dic objectForKey:@"description"];
        self.guid = [[dic objectForKey:@"guid"] longLongValue];
        
        self.positionId = [[dic objectForKey:@"id"] longLongValue];
        self.lat = [dic objectForKey:@"lat"];
        self.lon = [dic objectForKey:@"lon"];
        self.name = [dic objectForKey:@"name"];
        self.phone = [dic objectForKey:@"phone"];
        self.pub_date = [dic objectForKey:@"pub_date"];
        self.store_hours = [dic objectForKey:@"store_hours"];
        self.url = [dic objectForKey:@"url"];
        
    }
    return self;
}


@end
