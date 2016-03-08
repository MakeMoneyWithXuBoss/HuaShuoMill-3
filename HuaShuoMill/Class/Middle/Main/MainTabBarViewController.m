//
//  MainTabBarViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/10/26.
//  Copyright © 2015年 XinWo. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "MainTabBarView.h"
#import "TabBarButton.h"

#import "HomeViewController.h"
#import "CategoriesViewController.h"
#import "ProductCenterViewController.h"
#import "ContactUsViewController.h"
#import "MoreViewController.h"

@interface MainTabBarViewController ()<TabBarViewDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)MainTabBarView *customTabBar;


@end

@implementation MainTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.初始化tabBar
    [self setupTabbar];
    
    //2.初始化所有的子控制器
    [self setupAllChildViewControllers];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)loadConfigData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XHMDataService getRequestWithURL:API_Root params:params successBlock:^(id result) {
        APPLog(@"%@",result);
        
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    [self setupConfigRemoveViewData];
}

- (void)setupConfigRemoveViewData
{
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
        
        //if ([child isKindOfClass:[UIImageView class]]) {
        //    [child removeFromSuperview];
        //}
        
        if ([child isKindOfClass:[MainTabBarView class]]) {
            APPLog(@"%@---%@",self.customTabBar,child);
            [self.tabBar bringSubviewToFront:child];
        }
    }
    
    [self.tabBar bringSubviewToFront:self.customTabBar];
}


- (void)didSelectedViewControllerIndex:(NSUInteger)seletedIndex
{
    [self.customTabBar didSelectedButtonIndex:seletedIndex];
}


/**
 * 初始化tabBar
 */
#pragma mark - 初始化TabBar
- (void)setupTabbar
{
    MainTabBarView *customTabBar = [[MainTabBarView alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    
    [self.tabBar bringSubviewToFront:customTabBar];
    self.customTabBar = customTabBar;

}

/**
 *  初始化所有的子控制器
 */
#pragma mark - 初始化子控制器
- (void)setupAllChildViewControllers
{
    //1.首页
    HomeViewController *homePageVC = [[HomeViewController alloc] init];
    [self setupChildViewController:homePageVC title:@"首页" imageName:@"home.png" selectedImageName:@"home_selected.png"];
    
    //2.新闻资讯
    CategoriesViewController *newsInfoVC = [[CategoriesViewController alloc] init];
    [self setupChildViewController:newsInfoVC title:@"新闻资讯" imageName:@"newsInformation.png" selectedImageName:@"newsInformation_selected.png"];
    
    //3.产品中心
    ProductCenterViewController *productCenterVC = [[ProductCenterViewController alloc] init];
    [self setupChildViewController:productCenterVC title:@"产品中心" imageName:@"productCenter.png" selectedImageName:@"productCenter_selected.png"];
    
    //4.联系我们
    ContactUsViewController *contactUsVC = [[ContactUsViewController alloc] init];
    [self setupChildViewController:contactUsVC title:@"联系我们" imageName:@"contactus.png" selectedImageName:@"contactus_selected.png"];
    
    
    //5.更多
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    [self setupChildViewController:moreVC title:@"更多" imageName:@"more.png" selectedImageName:@"more_selected.png"];
    
    [self setupConfigRemoveViewData];
}

/**
 *  初始化一个控制器
 *
 *  @param childVC           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName
 */
- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //1、设置控制器的属性
    childVC.title = title;
    
    //self.tabBar.tintColor = RGBCOLOR(112,198,20);
    
    //2.设置图标
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    if (kVersion > 7.0) {
        childVC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVC.tabBarItem.selectedImage = selectedImage;
    }
    
    //2.包装一个导航控制器
    BaseNavigationViewController *baseNaviVC = [[BaseNavigationViewController alloc] initWithRootViewController:childVC];
    baseNaviVC.delegate = self;
    
    //设置标题文字颜色
    //NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    //attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:22];
    //[baseNaviVC.navigationBar setTitleTextAttributes:attrs];
    
    [self addChildViewController:baseNaviVC];

    //3.添加tabBar内部的按钮
    [self.customTabBar addTabBarButtonWithTitle:title imageName:imageName selectedImageName:selectedImageName];
    
}

- (void)tabBarView:(MainTabBarView *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

#pragma mark - 
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self setupConfigRemoveViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
