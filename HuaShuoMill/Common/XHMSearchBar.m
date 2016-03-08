//
//  SearchBar.m
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/3/26.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "XHMSearchBar.h"

@implementation XHMSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self setupConfigAttributeView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setupConfigAttributeView];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupConfigAttributeView];
}

- (void)setupConfigAttributeView
{
    self.font = [UIFont systemFontOfSize:15];
    self.placeholder = @"请输入搜索条件";
    self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    
    // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchIcon.width = 30;
    searchIcon.height = 30;
    searchIcon.contentMode = UIViewContentModeCenter;
    self.leftView = searchIcon;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    [self addTarget:self action:@selector(searchTextFieldBtnClick:) forControlEvents:UIControlEventEditingDidEndOnExit];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTextFieldChangeBtnClick:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.returnKeyType = UIReturnKeySearch;
}


- (void)searchTextFieldChangeBtnClick:(NSNotificationCenter *)note
{
//    APPLog(@"搜索关键字 %@",self.text);
//    if (self.searchDelegate != nil && [self.searchDelegate respondsToSelector:@selector(searchBar:didSelectedSearchBtnClickStartSearchKeyWord:)]) {
//        [self.searchDelegate searchBar:self didSelectedSearchBtnClickStartSearchKeyWord:self.text];
//    }
}

#pragma mark - 监听搜索按钮
- (void)searchTextFieldBtnClick:(UITextField *)textField
{
    APPLog(@"搜索关键字 %@",textField.text);
    if (self.searchDelegate != nil && [self.searchDelegate respondsToSelector:@selector(searchBar:didSelectedSearchBtnClickStartSearchKeyWord:)]) {
        [self.searchDelegate searchBar:self didSelectedSearchBtnClickStartSearchKeyWord:textField.text];
    }

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}


@end
