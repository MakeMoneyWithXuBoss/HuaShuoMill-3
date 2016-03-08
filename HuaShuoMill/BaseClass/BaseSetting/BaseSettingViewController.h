//
//  BaseSettingViewController.h
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/12.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseSettingViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray *dataArray;


@end
