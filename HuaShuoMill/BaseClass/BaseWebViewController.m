//
//  BaseWebViewController.m
//  YunYi_iOS_2.0
//
//  Created by YunYi on 15/4/8.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "BaseWebViewController.h"
#import "MBProgressHUD+Add.h"


@interface BaseWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic)  UIWebView *webView;

@property (nonatomic, readwrite, strong) NSURLRequest* loadRequest;
@property (nonatomic, readwrite, strong) MBProgressHUD *hud;

@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic,copy)NSString *shareTitle;


@property(nonatomic,copy)NSString *htmlString;//html数据

@end

@implementation BaseWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    [webView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth ];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    self.webView = webView;
}

- (void)setupShareTitle:(NSString *)shareTitle shareUrl:(NSString*)urlStr
{
    self.shareUrl = [NSString stringWithFormat:@"%@",urlStr];
    self.shareTitle = [NSString stringWithFormat:@"%@",shareTitle];
}

- (void)loadPageWithUrl:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self openRequest:[NSURLRequest requestWithURL:url]];
}

- (void)openRequest:(NSURLRequest *)request {
    self.loadRequest = request;
    if ([self isViewLoaded])
    {
        if (nil != request) {
            [self.webView loadRequest:request];
             self.webView.scalesPageToFit = YES;
            
        } else {
            [self.webView stopLoading];
        }
    }
}

- (void)loadPageWithPath:(NSString *)path title:(NSString *)title
{
    if (nil != path && [path length] > 0) {
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        self.htmlString = htmlString;
        self.webView.scalesPageToFit = NO;
        [self.webView loadHTMLString:htmlString baseURL:nil];
        self.title = title;
    } else {
        [self.webView stopLoading];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.loadRequest) {
        [self openRequest:self.loadRequest];
    }
    
    if (self.htmlString != nil && [self.htmlString length] > 0) {
        [self.webView loadHTMLString:self.htmlString baseURL:nil];

    }
}

#pragma mark - webView代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    
    
    if(!TTIsStringWithAnyText(self.title))
    {
        self.title =  [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        //获取当前页面的title
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
