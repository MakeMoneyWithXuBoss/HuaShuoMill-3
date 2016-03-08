//
//  UMShareEacPlatform.h
//  现货通
//
//  Created by XuHuiMing on 15/10/21.
//  Copyright © 2015年 BSY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UMShareEacPlatform : NSObject

+ (void)shareThisApp;

+ (void)shareThisAppSheetSheetView:(UIViewController *)controller shareTitle:(NSString *)shareTitle shareContent:(NSString *)shareContent shareURL:(NSString *)shareurl imageUrl:(NSString*)imgUrl;

@end
