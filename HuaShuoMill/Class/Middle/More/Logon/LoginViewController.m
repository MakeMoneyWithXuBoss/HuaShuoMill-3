                                                                                //
//  LoginViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/18.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteredViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
}


#pragma mark - 注册
- (IBAction)registeredBtnClick:(UIButton *)sender{
    
    RegisteredViewController *registeredVC = [[RegisteredViewController alloc] init];
    [self.navigationController pushViewController:registeredVC animated:YES];
}


#pragma mark - 登陆
- (IBAction)loginBtnClick:(UIButton *)sender {
    
    
    if (!TTIsStringWithAnyText(self.userNameTextField.text)) {//密码为空
        [Common showText:@"请输入账号"];
        //[[iToast makeText:@"请输入账号"] show];
        return;
    }
    
    if (!TTIsStringWithAnyText(self.passwordTextField.text)) {//密码为空
        [Common showText:@"请输入密码"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%@",self.userNameTextField.text] forKey:@"username"];
    [params setValue:[NSString stringWithFormat:@"%@",self.passwordTextField.text] forKey:@"password"];
    
    [XHMDataService postRequestWithURL:API_member_login params:params isShowLoading:YES successBlock:^(id result) {
        
        
        [SVProgressHUD showSuccessWithStatus:[result objectForKey:@"message"]];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } errorBlock:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
