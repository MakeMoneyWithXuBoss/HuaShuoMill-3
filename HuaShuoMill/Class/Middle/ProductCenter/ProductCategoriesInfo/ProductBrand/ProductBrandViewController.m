//
//  HomeViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ProductBrandViewController.h"

#import "BaseWebViewController.h"

#import "CycleFigureModel.h"
#import "ProductBrandModel.h"
#import "ProductBrandCell.h"
#import "ProductCenterModel.h"

#import "BrandCollectionViewCell.h"

#define  BrandCollectionViewCellID @"BrandCollectionViewCell"
#define kColOfMargin 10

#define kColOfRow 2
#define kCellSizeH 150
#define kCellSizeW ([UIScreen mainScreen].bounds.size.width - 3*kColOfMargin)/kColOfRow

@interface ProductBrandViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    int pageindex;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ProductBrandViewController

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
    
    [self setupConfigeTableView];
    
    
    [self setupConfigeCollectionView];
}

#pragma mark - 配置tableView
- (void)setupConfigeTableView
{
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

#pragma mark - 配置collectionView
- (void)setupConfigeCollectionView
{
    //1.流水布局
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    //UICollectionViewFlowLayout  *layout = (UICollectionViewFlowLayout
    //                                        *)self.collectionView.collectionViewLayout;
    //2.每个cell的尺寸
    CGFloat cellWidth = kCellSizeW;
    layout.itemSize = CGSizeMake(cellWidth, kCellSizeH);
    //3.设置cell之间的垂直间距
    layout.minimumLineSpacing = kColOfMargin;
    //4.设置cell之间的水平间距
    layout.minimumInteritemSpacing = kColOfMargin;
    //5.设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(kColOfMargin, kColOfMargin, kColOfMargin, kColOfMargin);
    
    //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //1.注册cell(告诉collectionView将来创建怎样的cell)
    UINib *nib = [UINib nibWithNibName:BrandCollectionViewCellID bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:BrandCollectionViewCellID];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:RGBColor(239,239,244)];
    
    __weak typeof(self) mySelf = self;
    //头部视图
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [mySelf performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.1f];
    }];
    
    //尾部视图
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [mySelf performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:YES] afterDelay:0.1];
    }];
    
    self.collectionView.mj_footer.hidden = YES;
    //自动刷新
    [self.collectionView.mj_header beginRefreshing];
    
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
    //[params setObject:[NSString stringWithFormat:@"%lld",self.category_id] forKey:@"category_id"]
    //http://118.123.16.62/appmill//index.php/api/products/getAll/category_id/2
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_products_getAll_category_id,self.category_id];


    [XHMDataService getRequestWithURL:urlString params:params isShowLoading:YES successBlock:^(id result) {
        
        if (pageindex == 1) {
            [self.dataArray removeAllObjects];
        }
        //列表数据
        NSMutableArray *categoriesArray = [result objectForKey:@"products"];
        for (NSMutableDictionary *categoriesDic in categoriesArray) {
            ProductBrandModel *productBrandModel = [[ProductBrandModel alloc] initWithDic:categoriesDic];
            [self.dataArray addObject:productBrandModel];
        }
        //[self.tableView reloadData];
        [self.collectionView reloadData];
        
        if([categoriesArray count]>=10)
        {
            self.tableView.mj_footer.hidden = NO;
            self.collectionView.mj_footer.hidden = NO;

        }
        else
        {
            self.tableView.mj_footer.hidden = YES;
            self.collectionView.mj_footer.hidden = YES;

        }
        
        self.isLoading = NO;
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    } errorBlock:^(NSError *error) {
        
        self.isLoading = NO;
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
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
    ProductBrandCell *cell = [ProductBrandCell cellWithTableView:tableView];
    
    ProductBrandModel *productBrandModel = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.productBrandModel = productBrandModel;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductBrandModel *productBrandModel = [self.dataArray objectAtIndex:indexPath.row];
    
    BaseWebViewController *baseWebVC = [[BaseWebViewController alloc] init];
    [baseWebVC loadPageWithUrl:productBrandModel.link];
    baseWebVC.title = [NSString stringWithFormat:@"%@",productBrandModel.title];
    
    [self.navigationController pushViewController: baseWebVC animated:YES];
}


#pragma mark - 返回按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)exchangeViewBtnClick:(UIButton *)sender {

    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.view bringSubviewToFront:self.tableView];
        [self.view sendSubviewToBack:self.collectionView];
        
        [self.tableView reloadData];
    }else{
        [self.view bringSubviewToFront:self.collectionView];
        [self.view sendSubviewToBack:self.tableView];
        
        [self.collectionView reloadData];

    }
   
   
}


#pragma mark - 
#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获得cell
    BrandCollectionViewCell *cell = (BrandCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:BrandCollectionViewCellID forIndexPath:indexPath];
    
    
    ProductBrandModel *productBrandModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.productBrandModel = productBrandModel;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductBrandModel *productBrandModel = [self.dataArray objectAtIndex:indexPath.row];
    
    BaseWebViewController *baseWebVC = [[BaseWebViewController alloc] init];
    [baseWebVC loadPageWithUrl:productBrandModel.link];
    baseWebVC.title = [NSString stringWithFormat:@"%@",productBrandModel.title];
    
    [self.navigationController pushViewController: baseWebVC animated:YES];
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
