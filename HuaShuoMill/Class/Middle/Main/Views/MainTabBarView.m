//
//  MainTabBarView.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/10/26.
//  Copyright © 2015年 XinWo. All rights reserved.
//

#import "MainTabBarView.h"
#import "TabBarButton.h"

@interface MainTabBarView()
@property (nonatomic, weak) TabBarButton *selectedButton;


@end
@implementation MainTabBarView

- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupCongfigView];
    }
    
    return self;
}

//初始化数据
- (void)setupCongfigView
{
    self.backgroundColor = RGBCOLOR(255, 255, 255);
}

- (TabBarButton *)addTabBarButtonWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //1.创建按钮
    TabBarButton *buttonItem = [[TabBarButton alloc] init];
    //buttonItem.imageView.contentMode = UIViewContentModeCenter;
    [buttonItem setTitle:title forState:UIControlStateNormal];
    [buttonItem setTitleColor:RGBCOLOR(161, 161, 161) forState:UIControlStateNormal];
    [buttonItem setTitleColor: RGBCOLOR(77,164,231) forState:UIControlStateSelected];
    
    [buttonItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [buttonItem setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    [self addSubview:buttonItem];
    [self.btnArray addObject:buttonItem];

    //2.监听按钮点击
    [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //4.默认选中第0个按钮
    if(self.subviews.count == 1){
        [self buttonClick:buttonItem];
    }
    
    return buttonItem;
}

- (void)didSelectedButtonIndex:(NSUInteger)seletedIndex
{
    TabBarButton *tabBarButton = [self.btnArray objectAtIndex:seletedIndex];
    [self buttonClick:tabBarButton];
    
}

- (void)buttonClick:(TabBarButton *)buttonItem
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButtonFrom:to:)])
    {
        [self.delegate tabBarView:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)buttonItem.tag];
    }
    
    //设置按钮状态
    self.selectedButton.selected = NO;
    buttonItem.selected = YES;
    self.selectedButton = buttonItem;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    //按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.btnArray.count; index ++)
    {
        //1.取出按钮
        TabBarButton *button = self.btnArray[index];
        
        //2.设置按钮的frame
        CGFloat buttonX = index * buttonW;

    
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //3.绑定tag
        button.tag = index;
    }
    
}

@end