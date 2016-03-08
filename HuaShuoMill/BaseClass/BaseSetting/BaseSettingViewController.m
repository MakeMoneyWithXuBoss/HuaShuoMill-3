//
//  BaseSettingViewController.m
//  LotteryTicket
//
//  Created by ios_ysj on 14/11/12.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "BaseSettingViewController.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingCell.h"
#import "SettingGroup.h"
#import "SettingItem.h"
#import "SettingTextFieldItem.h"

// 判断版本
#define kVersion [[UIDevice currentDevice].systemVersion floatValue]

#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface BaseSettingViewController ()

@property(nonatomic,weak)UITableView *tableView;

@end

@implementation BaseSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (kVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //tableView.contentInset = UIEdgeInsetsMake(-19, 0, 0, 0);
    }else{
     
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)view;
            self.tableView = tableView;
            tableView.sectionHeaderHeight = 16;
            tableView.sectionFooterHeight = 0;
            if (kVersion >= 7.0) {
                //tableView.contentInset = UIEdgeInsetsMake(-19, 0, 0, 0);
            }else{
                UIView *view = [[UIView alloc] init];
                //view.backgroundColor = RGBColor(240, 240, 240);
                tableView.backgroundView = view;
            }
            
        }
       
    }
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    return group.sectionItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建cell
    SettingCell *settingCell = [SettingCell cellWithTableView:tableView];
    
    //2、给cell传递模型数据
    SettingGroup *group = self.dataArray[indexPath.section];
    settingCell.settingItem = group.sectionItemArray[indexPath.row];
    
    
    //3、返回cell
    return settingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.取消选中这行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //2、模型数据
    SettingGroup *group = self.dataArray[indexPath.section];
    SettingItem *settingItem = group.sectionItemArray[indexPath.row];
    
    if(settingItem.operation){//block有值（）
        settingItem.operation();
        
    }else if([settingItem isKindOfClass:[SettingTextFieldItem class]]){
        
        //文本框
        //SettingTextFieldItem *settingTextFieldItem = (SettingTextFieldItem *)settingItem;
        //SettingCell *settingCell = (SettingCell *)[tableView cellForRowAtIndexPath:indexPath];
        //for (UITextField *textField in settingCell.contentView.subviews) {
        //    [textField becomeFirstResponder];
        //    if (TTIsStringWithAnyText(textField.text)) {
        //        settingTextFieldItem.textTitle = textField.text;
        //    }
        //    
        //    
        //}
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }else if([settingItem isKindOfClass:[SettingArrowItem class]]){
        
        //箭头
        SettingArrowItem *arrowItem = (SettingArrowItem *)settingItem;
        //如果没有需要跳转的控制器
        
        if (!arrowItem.destVcClass && !arrowItem.destVcObject) return;
        
        UIViewController *destVC;
        if (arrowItem.destVcClass){//提供目标类 自己创建
            destVC = [[arrowItem.destVcClass alloc] init];
            
        }
        
        if (arrowItem.destVcObject) {//提供目标对象 方便回调
            destVC = arrowItem.destVcObject;
        }
        
        destVC.view.backgroundColor = [UIColor whiteColor];
        destVC.title = arrowItem.title;
    
        [self.navigationController pushViewController:destVC animated:YES];
        //[self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.dataArray[section];
    return group.footerTitle;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
