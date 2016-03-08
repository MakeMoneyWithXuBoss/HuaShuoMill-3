//
//  BaseNavigationViewController.m
//  现货通
//
//  Created by XuHuiMing on 15/10/22.
//  Copyright (c) 2015年 BSY. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = RGBCOLOR(28, 137, 215);
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.fd_fullscreenPopGestureRecognizer.enabled=YES;
    
    
    //设置返回的箭头自定义图片
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
  
    UIImage  *backimage = [[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UINavigationBar appearance]  setBackIndicatorTransitionMaskImage:backimage];
    [[UINavigationBar appearance]  setBackIndicatorImage:backimage];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor blueColor]];
    //  去掉返回按钮文字
    UIBarButtonItem *baritem =[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    UIOffset offset;
    offset.horizontal = -500;
    //设置返回按钮的字体大小
    //[baritem  setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [baritem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    NSDictionary *titleAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:19],NSFontAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        ///第二层viewcontroller 隐藏tabbar
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:YES];
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
