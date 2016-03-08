//
//  CategoriesModel.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "bg_image" = "";
 created = "2010-01-20 21:26:49";
 "featured_image" = "";
 id = 1;
 img = "http://design.appmachine.com/Content/images/propertyeditor/placeholder_2.png";
 location = "";
 name = "\U5934\U6761";
 "parent_id" = 0;
 url = "";
 */

@interface CategoriesModel : NSObject

@property(nonatomic,copy)NSString *bg_image;
@property(nonatomic,copy)NSString *created;
@property(nonatomic,copy)NSString *featured_image;
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *parent_id;
@property(nonatomic,copy)NSString *url;


@end
