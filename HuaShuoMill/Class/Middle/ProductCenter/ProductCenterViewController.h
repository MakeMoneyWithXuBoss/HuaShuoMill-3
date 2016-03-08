//
//  NewsInfoViewController.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "BaseViewController.h"
#import "BTVPageViewController.h"

@interface ProductCenterViewController : BTVPageViewController<BTVPageViewDataSource, BTVPageViewDelegate>

@property (strong, nonatomic) BTVPageViewController *viewPage;
@property (strong, nonatomic) NSMutableArray *pageTitleArray;

@end
