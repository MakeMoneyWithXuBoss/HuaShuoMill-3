//
//  BaseWebViewController.h
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/4/8.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController

@property (nonatomic,strong)NSString *detailtitle;


- (void)loadPageWithUrl:(NSString*)urlStr;

//用户分享
- (void)setupShareTitle:(NSString *)shareTitle shareUrl:(NSString*)urlStr;



- (void)loadPageWithPath:(NSString *)path title:(NSString *)title;


@end
