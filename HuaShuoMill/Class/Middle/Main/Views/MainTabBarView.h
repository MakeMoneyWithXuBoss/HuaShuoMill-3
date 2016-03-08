//
//  MainTabBarView.h
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/10/26.
//  Copyright © 2015年 XinWo. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MainTabBarView,TabBarButton;

@protocol TabBarViewDelegate <NSObject>
@optional
- (void)tabBarView:(MainTabBarView *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

- (void)tabBarDidClickedPlusButton:(MainTabBarView *)tabBar;

@end

@interface MainTabBarView : UIView

@property(nonatomic,strong)NSMutableArray *btnArray;


- (TabBarButton *)addTabBarButtonWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

- (void)didSelectedButtonIndex:(NSUInteger)seletedIndex;

@property(nonatomic,weak)id<TabBarViewDelegate> delegate;

@end