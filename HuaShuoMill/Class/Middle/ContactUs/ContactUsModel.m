//
//  HomeCollectionModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ContactUsModel.h"

@implementation ContactUsModel


- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.category_id = [[dic objectForKey:@"category_id"] longLongValue];
        self.descri = [dic objectForKey:@"description"];
        self.guid = [[dic objectForKey:@"guid"] longLongValue];
        self.image = [dic objectForKey:@"image"];
        self.link = [dic objectForKey:@"link"];
        self.pub_date = [dic objectForKey:@"pub_date"];
        self.title = [dic objectForKey:@"title"];
        self.type = [dic objectForKey:@"type"];
        self.contactUsId = [[dic objectForKey:@"id"] longLongValue];
    }
    return self;
}




@end
