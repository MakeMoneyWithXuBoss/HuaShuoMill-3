//
//  HomeCollectionModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ProductCollectionModel.h"

@implementation ProductCollectionModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.productBrandModel_id = [[dic objectForKey:@"id"] longLongValue];
        self.guid = [[dic objectForKey:@"guid"] longLongValue];
        self.title = [dic objectForKey:@"title"];
        self.category_id = [[dic objectForKey:@"category_id"] longLongValue];
        self.descr = [dic objectForKey:@"description"];
        self.link = [dic objectForKey:@"link"];
        self.img = [dic objectForKey:@"img"];
    }
    return self;
}


//- (instancetype)initWithDic:(NSDictionary *)dic
//{
//    self = [super init];
//    if (self) {
//        self.category_id = [[dic objectForKey:@"category_id"] longLongValue];
//        self.descr = [dic objectForKey:@"description"];
//        self.fullpost = [dic objectForKey:@"fullpost"];
//        self.guid = [[dic objectForKey:@"guid"] longLongValue];
//        self.collectionId = [[dic objectForKey:@"id"] longLongValue];
//        
//        self.img = [dic objectForKey:@"img"];
//        self.isTop = [[dic objectForKey:@"isTop"] longLongValue];
//        self.link = [dic objectForKey:@"link"];
//        self.pub_date = [dic objectForKey:@"pub_date"];
//        self.subtitle = [dic objectForKey:@"subtitle"];
//        self.timeago = [dic objectForKey:@"timeago"];
//        self.title = [dic objectForKey:@"title"];
//        self.total_comments = [[dic objectForKey:@"total_comments"] longLongValue];
//        self.type = [dic objectForKey:@"official"];
//
//    }
//    return self;
//}


@end
