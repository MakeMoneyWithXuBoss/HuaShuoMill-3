//
//  HomeViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "LinkInfoViewController.h"

#import "LinkInfoModel.h"
#import "LinkInfoCell.h"

#import "ProductBrandViewController.h"

@interface LinkInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int pageindex;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LinkInfoViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:RGBColor(239,239,244)];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)searchBtnClick:(UIButton *)button
{
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
 
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XHMDataService getRequestWithURL:API_links_getAll  params:params isShowLoading:YES successBlock:^(id result) {
        
        [self.dataArray removeAllObjects];
        
        //列表数据
        NSMutableArray *categoriesArray = [result objectForKey:@"links"];
        for (NSMutableDictionary *linkDic in categoriesArray) {
            LinkInfoModel *linkInfoModel = [[LinkInfoModel alloc] initWithDic:linkDic];
            
            [self.dataArray addObject:linkInfoModel];
        }
        [self.tableView reloadData];
        
        
        self.isLoading = NO;
    } errorBlock:^(NSError *error) {
        
        self.isLoading = NO;
    }];
    
}


#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.dataArray count] == 0) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建单元格
    LinkInfoCell *cell = [LinkInfoCell cellWithTableView:tableView];
    
    LinkInfoModel *linkInfoModel = [self.dataArray objectAtIndex:indexPath.row];

    cell.linkInfoModel = linkInfoModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    

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
