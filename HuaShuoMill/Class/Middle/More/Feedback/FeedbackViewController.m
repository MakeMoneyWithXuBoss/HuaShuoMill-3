//
//  PersonalProfileViewController.m
//  YunYi_iOS_2.0
//
//  Created by XuhuiMing on 15/4/12.
//  Copyright (c) 2015年 XuhuiMing. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UITextField *teleTextField;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.delegate = self;
    
    [self setupConfigNavigationBar];
    
}

- (void)setupConfigNavigationBar
{
    [self setRightBarButtonItem:[UIBarButtonItem itemWithIcon:@"send.png" highlightIcon:@"send.png" target:self action:@selector(sendBtnClick:)]];
}

- (void)sendBtnClick:(UIButton *)button
{
    [self requestFeedBackData];
}


#pragma mark - 请求意见反馈数据
- (void)requestFeedBackData
{
    
    if (!TTIsStringWithAnyText(self.contentTextView.text)) {
        [SVProgressHUD showErrorWithStatus:@"说点什么吧" maskType:SVProgressHUDMaskTypeNone];

        return;
    }
    
    if (!TTIsStringWithAnyText(self.teleTextField.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入你的号码" maskType:SVProgressHUDMaskTypeNone];

        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSString stringWithFormat:@"%@",self.contentTextView.text] forKey:@"content"];
    [params setObject:[NSString stringWithFormat:@"%@",self.teleTextField.text] forKey:@"contact"];

    
    [XHMDataService postRequestWithURL:API_feedback_add params:params isShowLoading:YES  successBlock:^(id result) {
        
        
        APPLog(@"%@",result);
        BOOL success = [[result objectForKey:@"status"] boolValue];
        if (success) {
            NSString *message = [result objectForKey:@"message"];
            //[[iToast makeText:message] show];
            
            [SVProgressHUD showWithStatus:message];

    
            [self.navigationController popViewControllerAnimated:YES];
        }
        
     
        
    } errorBlock:^(NSError *error) {
        
        
    }];
    
}



//以上集合一起，并兼容14开头的
//- (BOOL)isMobileNumber:(NSString *)mobileNum
//{
//    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
//    BOOL isMatch = [mobileNum isMatchedByRegex:phoneRegex];
//    return isMatch;
//}

#pragma mark - 提交数据
- (IBAction)commitBtnClick:(UIButton *)sender {
    
    
    [self.view endEditing:YES];

    [self requestFeedBackData];
}


#pragma mark - 滚动收起
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
