//
//  SettingHelpViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/12/16.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "SettingHelpViewController.h"

#import "SettingItem.h"
#import "SettingSwitchItem.h"
#import "SettingGroup.h"
#import "SettingCell.h"

#import "LinkInfoViewController.h"
#import "FeedbackViewController.h"

#import "ProductCollectionViewController.h"

@interface SettingHelpViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SettingHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
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
    
    SettingSwitchItem *settingItem0 = [SettingSwitchItem itemWithTitle:@"系统通知" isOpen:NO];
    
    SettingGroup *group = [SettingGroup group];
    group.sectionItemArray = @[settingItem0];
    [self.dataArray addObject:group];
}

- (void)setupGroup1
{
    
    SettingSwitchItem *settingItem0 = [SettingSwitchItem itemWithTitle:@"新浪微博" isOpen:YES];
    __weak SettingSwitchItem *weekSettingItem0 = settingItem0;
    settingItem0.operation = ^{
        weekSettingItem0.isOpen =  !weekSettingItem0.isOpen;
        
        [self.tableView reloadData];
    };
    
    SettingSwitchItem *settingItem1 = [SettingSwitchItem itemWithTitle:@"腾讯微博" isOpen:YES];
    __weak SettingSwitchItem *weekSettingItem1 = settingItem1;
    settingItem0.operation = ^{
        weekSettingItem1.isOpen =  !weekSettingItem1.isOpen;
        
        [self.tableView reloadData];
    };

    SettingSwitchItem *settingItem2 = [SettingSwitchItem itemWithTitle:@"人人网" isOpen:YES];
    __weak SettingSwitchItem *weekSettingItem2 = settingItem2;
    settingItem2.operation = ^{
        weekSettingItem2.isOpen =  !weekSettingItem2.isOpen;
        
        [self.tableView reloadData];
    };

    SettingGroup *group = [SettingGroup group];
    group.sectionItemArray = @[settingItem0,settingItem1,settingItem2];
    group.headerTitle = @"分享设置";
    [self.dataArray addObject:group];
    
}


- (void)setupGroup2
{
    
    SettingItem *settingItem0 = [SettingItem itemWithTitle:@"清除缓存"];
    
    SettingGroup *group = [SettingGroup group];
    group.sectionItemArray = @[settingItem0];
    [self.dataArray addObject:group];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
