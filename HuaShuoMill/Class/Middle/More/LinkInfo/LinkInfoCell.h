//
//  ProductCenterInfoCell.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/4.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkInfoModel.h"

@interface LinkInfoCell : BaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)LinkInfoModel *linkInfoModel;

@end
