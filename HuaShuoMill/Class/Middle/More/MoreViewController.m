//
//  MoreViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "MoreViewController.h"
#import "SettingItem.h"
#import "SettingLabelArrowItem.h"
#import "SettingGroup.h"
#import "SettingCell.h"

#import "LinkInfoViewController.h"
#import "FeedbackViewController.h"
#import "SettingHelpViewController.h"

#import "QuestionAllViewController.h"

#import "LoginViewController.h"
#import "PhotoAlbumViewController.h"
#import "PositionSearchViewController.h"
#import "VideoLiveViewController.h"

#import "ProductCollectionViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.tableView setBackgroundColor:RGBColor(239,239,244)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)setupGroup0
{
    SettingItem *settingItem4 = [SettingLabelArrowItem itemWithTitle:@"产品收藏夹" subTitle:@"" destVcClass:[ProductCollectionViewController class]];

    SettingItem *settingItem0 = [SettingLabelArrowItem itemWithTitle:@"链接" subTitle:@"" destVcClass:[LinkInfoViewController class]];
    SettingItem *settingItem1 = [SettingLabelArrowItem itemWithTitle:@"关于" subTitle:@"" destVcClass:[UIViewController class]];
    SettingItem *settingItem2 = [SettingLabelArrowItem itemWithTitle:@"意见反馈" subTitle:@"" destVcClass:[FeedbackViewController class]];
    SettingItem *settingItem3 = [SettingLabelArrowItem itemWithTitle:@"常见问题" subTitle:@"" destVcClass:[QuestionAllViewController class]];


    SettingGroup *group = [SettingGroup group];
    group.sectionItemArray = @[settingItem4,settingItem0,settingItem1,settingItem2,settingItem3];
    [self.dataArray addObject:group];
}

- (void)setupGroup1
{
    SettingItem *settingItem0 = [SettingLabelArrowItem itemWithTitle:@"相册" subTitle:@"" destVcClass:[PhotoAlbumViewController class]];
    SettingItem *settingItem1 = [SettingLabelArrowItem itemWithTitle:@"位置" subTitle:@"" destVcClass:[PositionSearchViewController class]];
    
    SettingItem *settingItem2 = [SettingLabelArrowItem itemWithTitle:@"我" subTitle:@"" destVcClass:[LoginViewController class]];
    
    SettingItem *settingItem3 = [SettingLabelArrowItem itemWithTitle:@"视频" subTitle:@"" destVcClass:[VideoLiveViewController class]];
    
    SettingGroup *group = [SettingGroup group];
    group.sectionItemArray = @[settingItem0,settingItem1,settingItem2,settingItem3];
    [self.dataArray addObject:group];
    
}

- (void)setupGroup2
{
   
    SettingItem *settingItem0 = [SettingLabelArrowItem itemWithTitle:@"设置" subTitle:@"" destVcClass:[SettingHelpViewController class]];
    
    SettingGroup *group = [SettingGroup group];
    group.sectionItemArray = @[settingItem0];
    [self.dataArray addObject:group];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
