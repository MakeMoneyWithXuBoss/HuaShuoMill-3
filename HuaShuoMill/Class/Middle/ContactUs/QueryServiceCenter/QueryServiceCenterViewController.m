//
//  HomeViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "QueryServiceCenterViewController.h"

#import "QueryServiceModel.h"
#import "QueryServiceCenterCell.h"

#import "ProductBrandViewController.h"
#import "QueryServiceDetailViewController.h"

@interface QueryServiceCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int pageindex;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation QueryServiceCenterViewController

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
    
    
    __weak typeof(self) mySelf = self;
    //头部视图
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [mySelf performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.1f];
    }];
    
    
    //尾部视图
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [mySelf performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.1];
    }];
    
    
    self.tableView.mj_footer.hidden = YES;
    //自动刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}


#pragma mark - 左右导航栏
- (void)setupConfigNavigationBar
{    
    [self setLeftBarButtonItem:[UIBarButtonItem itemWithTitle:@"确定" target:self action:@selector(searchBtnClick:)]];
}
- (void)searchBtnClick:(UIButton *)button
{
    
}


- (void)loadData:(NSNumber*)more
{
    if (self.isLoading) {
        return;
    }
    
    self.isLoading = YES;
    
    if(more.boolValue == YES)
    {
        pageindex++;
    }
    else
    {
        pageindex = 1;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //[params setObject:[NSString stringWithFormat:@"%@",self.category_id] forKey:@"category_id"];
    
  
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_products_category_id,@"1"];
    


    [XHMDataService getRequestWithURL:urlString params:params isShowLoading:YES successBlock:^(id result) {
        
        if (pageindex == 1) {
            [self.dataArray removeAllObjects];
        }
        
        //列表数据
        NSMutableArray *categoriesArray = [result objectForKey:@"categories"];
        
        
        for (NSMutableDictionary *collectionDic in categoriesArray) {
            QueryServiceModel *productCategoriesInfoModel = [[QueryServiceModel alloc] init];
            [productCategoriesInfoModel setValuesForKeysWithDictionary:collectionDic];
            [self.dataArray addObject:productCategoriesInfoModel];
        }
        [self.tableView reloadData];
        
        if([categoriesArray count]>=10)
        {
            self.tableView.mj_footer.hidden = NO;
        }
        else
        {
            self.tableView.mj_footer.hidden = YES;
        }
        
        self.isLoading = NO;
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } errorBlock:^(NSError *error) {
        
        self.isLoading = NO;
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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
    QueryServiceCenterCell *cell = [QueryServiceCenterCell cellWithTableView:tableView];
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    QueryServiceDetailViewController *queryServiceDetailVC = [[QueryServiceDetailViewController alloc] init];
    [self.navigationController pushViewController:queryServiceDetailVC animated:YES];
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
