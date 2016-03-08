//
//  SearchBar.h
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/3/26.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHMSearchBar;
@protocol XHMSearchBarDelegate <NSObject>

@optional
- (void)searchBar:(XHMSearchBar *)searchBar   didSelectedSearchBtnClickStartSearchKeyWord:(NSString *)keyword;
@end

@interface XHMSearchBar : UITextField

+ (instancetype)searchBar;

@property(nonatomic,assign)id<XHMSearchBarDelegate> searchDelegate;


@end
