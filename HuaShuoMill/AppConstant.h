//
//  APIConstant.h
//  DoctorAssistant
//
//  Created by ios_ysj on 14/11/9.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//


//友盟分享
#define UmengAppkey @"5615db9ae0f55aba62002657"


// 判断是否为iOS7
#define kVersion [[UIDevice currentDevice].systemVersion floatValue]
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 获得RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define StringColorFromRGBValue(stringColor) [UIColor colorWithRed:((float)((stringColor & 0xFF0000) >> 16))/255.0 green:((float)((stringColor & 0xFF00) >> 8))/255.0 blue:((float)(stringColor & 0xFF))/255.0 alpha:1.0]



#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

// 自定义Log
#ifdef DEBUG
#define APPLog(...) NSLog(__VA_ARGS__)
#else
#define APPLog(...)
#endif

#import "UIViewExt.h"
#import "MBProgressHUD+Add.h"

#import "MJRefresh.h"
#import "Common.h"
#import "UMShareEacPlatform.h"
#import "XHMDataService.h"
#import "UIImageView+WebCache.h"
#import "BaseWebViewController.h"
#import "UIViewController+MarginBarButtonItem.h"
#import "UIBarButtonItem+CustomButtonItem.h"
#import "MMDrawerController.h"
#import "BaseTableViewCell.h"
#import "BasePushSubViewController.h"
#import "SVProgressHUD.h"
#import <BaiduMapAPI/BMapKit.h>












