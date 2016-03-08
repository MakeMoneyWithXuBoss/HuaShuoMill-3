//
//  NewsInfoViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoriesInfoViewController.h"

#import "CategoriesModel.h"

@interface CategoriesViewController ()<NavigationSubViewControllerDelegate>

@property(nonatomic,strong)NSMutableDictionary *tabsDictionary;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CategoriesViewController


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableArray *)pageTitleArray
{
    if (_pageTitleArray == nil) {
        _pageTitleArray = [NSMutableArray array];
    }
    
    return _pageTitleArray;
}

- (NSMutableDictionary *)tabsDictionary
{
    if (_tabsDictionary == nil) {
        _tabsDictionary = [NSMutableDictionary dictionary];
    }
    
    return _tabsDictionary;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.dataSource = self;
    self.delegate = self;
    
    [self requestNetData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - 请求网络数据
- (void)requestNetData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [XHMDataService getRequestWithURL:API_news_category params:params isShowLoading:YES successBlock:^(id result) {
       
        [self.pageTitleArray removeAllObjects];
        NSMutableArray *categoriesArray = [result objectForKey:@"categories"];
        
        for (NSMutableDictionary *categorieDic in categoriesArray) {
            CategoriesModel *categoriesModel = [[CategoriesModel alloc] init];
            [categoriesModel setValuesForKeysWithDictionary:categorieDic];
            [self.pageTitleArray addObject:categoriesModel];
        }
        
        
        self.viewPage = [[BTVPageViewController alloc] init];
        [self.viewPage setDataSource:self];
        [self.viewPage setDelegate:self];
        self.viewPage.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49);
        [self.view addSubview:self.viewPage.view];
        
    } errorBlock:^(NSError *error) {
        
      
        
    }];
}


#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForBTVPageView:(BTVPageViewController *)BTVPageView;
{
    return self.pageTitleArray.count;
}

- (NSMutableArray *)widthOfTabsForBTVPageView:(BTVPageViewController *)BTVPageView
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSString *tabWidth;
    NSString *widthSize;
    CGSize fitSize;
    
    for (int i= 0; i < [self.pageTitleArray count]; i++)
    {
        CategoriesModel *categoriesModel = [self.pageTitleArray objectAtIndex:i];
        tabWidth = [NSString stringWithFormat:@"%@",categoriesModel.name];

        fitSize = [tabWidth sizeWithFont:[UIFont boldSystemFontOfSize:14.0]];
        
        widthSize = [NSString stringWithFormat:@"%f", kScreenWidth/self.pageTitleArray.count];//;fitSize.width + 17
        
        [array addObject:widthSize];
    }

    return array;
}

- (UIView *)BTVPageView:(BTVPageViewController *)BTVPageView viewForTabAtIndex:(NSUInteger)index
{
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.backgroundColor = [UIColor clearColor];
    //titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    CategoriesModel *categoriesModel =  [self.pageTitleArray objectAtIndex:index];
    
    titleLabel.text = [NSString stringWithFormat:@"%@",categoriesModel.name];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    
    titleLabel.tag = index + 400;
    [titleLabel sizeToFit];
    
    [self.tabsDictionary setObject:titleLabel forKey:@(index)];
    
    return titleLabel;
}

- (UIViewController *)BTVPageView:(BTVPageViewController *)BTVPageView contentViewControllerForTabAtIndex:(NSUInteger)index
{
    CategoriesInfoViewController *currentVC = [[CategoriesInfoViewController alloc] init];
    currentVC.delegate = self;
    
    CategoriesModel *categoriesModel =  [self.pageTitleArray objectAtIndex:index];
    currentVC.category_id = categoriesModel.id;
    
    currentVC.view.backgroundColor = RGBCOLOR(239, 239, 239);
    currentVC.view.clipsToBounds = YES;
    return currentVC;
    
}

#pragma mark - 切换到不同的子控制器
- (void)BTVPageView:(BTVPageViewController *)BTVPageView didChangeTabToIndex:(NSUInteger)index
{
    if ([[self.tabsDictionary objectForKey:@(index)] isKindOfClass:[UILabel class]]) {
        UILabel *titleLabel = (UILabel *)[self.tabsDictionary objectForKey:@(index)];
        titleLabel.textColor =  RGBCOLOR(28, 137, 215);
    }
    
}

#pragma mark -
- (void)BTVPageView:(BTVPageViewController *)BTVPageView didChangeTabFromIndex:(NSUInteger)fromIndex
{
    //到那里去
    if ([[self.tabsDictionary objectForKey:@(fromIndex)] isKindOfClass:[UILabel class]]) {
        UILabel *titleLabel = (UILabel *)[self.tabsDictionary objectForKey:@(fromIndex)];
        titleLabel.textColor = [UIColor grayColor];
    }
}


#pragma mark - 子类跳转
- (void)pushSubViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - ViewPagerDelegate
- (CGFloat)BTVPageView:(BTVPageViewController *)BTVPageView valueForOption:(BTVPageViewOption)option withDefault:(CGFloat)value
{
    switch (option) {
        case BTVPageViewOptionTabHeight:
            return 40.0;//return 44.0;
            break;
        case BTVPageViewOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}

- (UIColor *)BTVPageView:(BTVPageViewController *)BTVPageView colorForComponent:(BTVPageViewComponent)component withDefault:(UIColor *)color
{
    switch (component)
    {
        case BTVPageViewIndicator:
            return RGBCOLOR(28, 137, 215);
            break;
            
        case BTVPageViewTabsView:
            return [UIColor whiteColor];
            break;
        default:
            break;
    }
    
    return color;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
