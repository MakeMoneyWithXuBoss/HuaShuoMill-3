//
//  HomeViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"

#import "CycleFigureModel.h"
#import "HomeCollectionModel.h"
#import "HomeCollectionCell.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    int pageindex;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *cycleFigureData;//轮播图

@end

@implementation HomeViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

#pragma mark - 轮播图数据
- (NSMutableArray *)cycleFigureData
{
    if (_cycleFigureData == nil) {
        _cycleFigureData = [NSMutableArray array];
    }
    
    return _cycleFigureData;
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

    [XHMDataService getRequestWithURL:API_collection_getAll params:params isShowLoading:YES successBlock:^(id result) {
        
        if (pageindex == 1) {
            [self.dataArray removeAllObjects];
        }
        
        //轮播图
        [self.cycleFigureData removeAllObjects];
        NSMutableArray *headersArray = [result objectForKey:@"header"];
        for (NSMutableDictionary *cycleFigureDic in headersArray) {
            CycleFigureModel *cycleFigureModel = [[CycleFigureModel alloc] init];
            [cycleFigureModel setValuesForKeysWithDictionary:cycleFigureDic];
            [self.cycleFigureData addObject:cycleFigureModel];
        }
        [self addScrollView:self.cycleFigureData];
        
    
        //列表数据
        NSMutableArray *collectionsArray = [result objectForKey:@"collection"];
        for (NSMutableDictionary *collectionDic in collectionsArray) {
            HomeCollectionModel *homeCollectionModel = [[HomeCollectionModel alloc] initWithDic:collectionDic];
            [self.dataArray addObject:homeCollectionModel];
        }
        [self.tableView reloadData];
        
        if([collectionsArray count]>=10)
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



#pragma mark -  轮播图
-(void)addScrollView:(NSMutableArray *)cycleArray//请求数据
{
    NSMutableArray *urlArray =[NSMutableArray array];
    for (CycleFigureModel *cycleFigureModel in cycleArray) {
        [urlArray addObject:cycleFigureModel.img];
    }
    if ([urlArray count] <= 0) {
        return;
    }
    //轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,kScreenWidth, 160) imagesGroup:urlArray];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = 2.0;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    headView.backgroundColor = RGBColor(230, 230, 230);
    [headView addSubview:cycleScrollView];
    
    self.tableView.tableHeaderView = headView;
    
}

#pragma mark - SDCycleScrollViewDelegate
//代理  点击第几张图片
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
  
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
    HomeCollectionCell *newsCell = [HomeCollectionCell cellWithTableView:tableView];
    
    HomeCollectionModel *homeCollectionModel = [self.dataArray objectAtIndex:indexPath.row];
    
    newsCell.homeCollectionModel = homeCollectionModel;
    
    return newsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
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
