//
//  HomeCollectionModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "HotProductModel.h"

@implementation HotProductModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.hotProductID = [[dic objectForKey:@"id"] longLongValue];
        self.category_id = [[dic objectForKey:@"category_id"] longLongValue];
        self.title = [dic objectForKey:@"title"];
        self.link = [dic objectForKey:@"link"];
        self.descri = [dic objectForKey:@"description"];
        self.img = [dic objectForKey:@"img"];
    }
    return self;
}



@end
