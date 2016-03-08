//
//  CategoriesModel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ProductCategoriesModel.h"

@implementation ProductCategoriesModel


/*
 "id": "1",
 "name": "\u624b\u673a",
 "viewStyle": "default",
 "created": "2010-01-20 21:26:49",
 "parent_id": "0",
 "img": "http:\/\/design.appmachine.com\/Content\/images\/propertyeditor\/placeholder_2.png",
 "featured_image": "",
 "bg_image": "",
 "location": "",
 "url": "",
 "title": "\u624b\u673a",
 "tag": "category"
 */

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.productCategoriesId = [dic objectForKey:@"id"];
        self.name = [dic objectForKey:@"name"];
        self.viewStyle = [dic objectForKey:@"viewStyle"];
        self.created = [dic objectForKey:@"created"];
        self.parent_id = [dic objectForKey:@"parent_id"];
        self.img = [dic objectForKey:@"img"];
        self.featured_image = [dic objectForKey:@"featured_image"];
        self.location = [dic objectForKey:@"location"];
        self.url = [dic objectForKey:@"url"];
        self.title = [dic objectForKey:@"title"];
        self.tag = [dic objectForKey:@"tag"];

    }
    return self;
}


@end
