//
//  HomeViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "HotProductViewController.h"

#import "HotProductModel.h"
#import "HotProductCell.h"


#define  HotProductCellID @"HotProductCell"
#define kColOfMargin 0

#import "ProductBrandViewController.h"

@interface HotProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    int pageindex;
}


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;


@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HotProductViewController

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

    [self setupConfigeCollectionView];
    
    [self setupConfigNavigationBar];
    
}

#pragma mark - 配置collectionView
- (void)setupConfigeCollectionView
{
    //1.流水布局
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    //UICollectionViewFlowLayout  *layout = (UICollectionViewFlowLayout
    //                                        *)self.collectionView.collectionViewLayout;
    //2.每个cell的尺寸
    CGFloat cellWidth = kScreenWidth;
    layout.itemSize = CGSizeMake(cellWidth, kScreenHeight-64-49);
    //3.设置cell之间的垂直间距
    layout.minimumLineSpacing = kColOfMargin;
    //4.设置cell之间的水平间距
    layout.minimumInteritemSpacing = kColOfMargin;
    //5.设置四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(kColOfMargin, kColOfMargin, kColOfMargin, kColOfMargin);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:RGBColor(239,239,244)];
    
    //1.注册cell(告诉collectionView将来创建怎样的cell)
    UINib *nib = [UINib nibWithNibName:HotProductCellID bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:HotProductCellID];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self performSelector:@selector(loadData:) withObject:[NSNumber numberWithBool:NO] afterDelay:0.1];
}

#pragma mark - 左右导航栏
- (void)setupConfigNavigationBar
{
    [self setRightBarButtonItem:[UIBarButtonItem itemWithTitle:@"确定" target:self action:@selector(searchBtnClick:)]];
    
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
    NSString *urlString = [NSString stringWithFormat:@"%@/products/top",API_Root];;

    [XHMDataService getRequestWithURL:urlString params:params isShowLoading:YES successBlock:^(id result) {
        
        if (pageindex == 1) {
            [self.dataArray removeAllObjects];
        }
        
        
        NSMutableArray *categoriesArray = [result objectForKey:@"products"];

        
        
        for (NSMutableDictionary *collectionDic in categoriesArray) {
            HotProductModel *hotProductModel = [[HotProductModel alloc] initWithDic:collectionDic];
            [self.dataArray addObject:hotProductModel];
        }
        [self.collectionView reloadData];
        
        if([categoriesArray count]>=10)
        {
            self.collectionView.mj_footer.hidden = NO;
        }
        else
        {
            self.collectionView.mj_footer.hidden = YES;
        }
        
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


#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获得cell
    HotProductCell *cell = (HotProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:HotProductCellID forIndexPath:indexPath];
    
    HotProductModel *hotProductModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.hotProductModel = hotProductModel;
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotProductModel *hotProductModel = [self.dataArray objectAtIndex:indexPath.row];
    
    BaseWebViewController *baseWebVC = [[BaseWebViewController alloc] init];
    baseWebVC.title = [NSString stringWithFormat:@"%@",hotProductModel.title];
    
    [baseWebVC loadPageWithUrl:hotProductModel.link];
    
    [self.delegate pushSubViewController:baseWebVC];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.collectionView.width * 0.5) / self.collectionView.width;
    int indexOnPageControl = itemIndex % self.dataArray.count ;
    self.pageControl.currentPage = indexOnPageControl;
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
