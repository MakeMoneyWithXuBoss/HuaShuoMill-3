//
//  BaseTableViewCell.m
//  YunYi
//
//  Created by YunYi on 15/3/25.
//  Copyright (c) 2015年 XuHuiMing. All rights reserved.
//

#import "BaseTableViewCell.h"


#define BaseTableViewCellBackground  RGBColor(248,248,248) // 所有单元格背景颜色均为：#f6f6f6      RGB:248 248 248
#define BaseTableViewCellSelecteBackground  RGBColor(230,230,230) // 所有单元格选中背景颜色均为：#f6f6f6      RGB:239 239 239

@implementation BaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"BaseTableViewCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupInitializationView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupInitializationView];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setupInitializationView
{
    [self setupBg];
}

/**
 *  初始化背景
 */
- (void)setupBg
{
    // 设置普通背景
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bg;
    
    // 设置选中时的背景
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor =  BaseTableViewCellSelecteBackground;
    self.selectedBackgroundView = selectedBg;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for(UIView *view in self.subviews) {
#if TARGET_IPHONE_SIMULATOR
        Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
        if ([view isKindOfClass:class]) {
            view.left = 0;
            view.height = 0.5;
            view.width = [UIScreen mainScreen].bounds.size.width;
        }
#else
        for (UIView *subView in view.subviews) {
            Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
            if ([subView isKindOfClass:class]) {
                subView.left = 0;
                subView.height = 0.5;
                subView.width = [UIScreen mainScreen].bounds.size.width;
            }
        }
#endif
       
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            
            Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
            if ([view isKindOfClass:class]) {
                view.left = 0;
                view.height = 0.5;
                view.width = [UIScreen mainScreen].bounds.size.width;
            }
        }else{
            
            for (UIView *subView in view.subviews) {
                Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
                if ([subView isKindOfClass:class]) {
                    subView.left = 0;
                    subView.height = 0.5;
                    subView.width = [UIScreen mainScreen].bounds.size.width;
                }
            }
        }
        
    }
    
    
//#if !TARGET_IPHONE_SIMULATOR
//    for (UIView *view in self.subviews) {
//        Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
//        if ([view isKindOfClass:class]) {
//            view.left = 0;
//            view.height = 0.5;
//            view.width = [UIScreen mainScreen].bounds.size.width;
//        }
//    }
//#endif
    
//    _UITableViewCellSeparatorView
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
