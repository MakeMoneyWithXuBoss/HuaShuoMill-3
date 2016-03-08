//
//  RegisteredViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 16/1/18.
//  Copyright © 2016年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "RegisteredViewController.h"
@interface RegisteredViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatpasswordTextField;


@end

@implementation RegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"注册";
    
    
    self.userNameTextField.returnKeyType = UIReturnKeyDone;
    self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    
    self.repeatpasswordTextField.secureTextEntry = YES;
    self.repeatpasswordTextField.returnKeyType = UIReturnKeyDone;

}


#pragma mark - 完成
- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    if (!TTIsStringWithAnyText(self.userNameTextField.text)) {//密码为空
        [Common showText:@"请输入账号"];
        //[[iToast makeText:@"请输入账号"] show];
        return;
    }
    
    if (!TTIsStringWithAnyText(self.passwordTextField.text)) {//密码为空
        [Common showText:@"请输入密码"];
        //[[iToast makeText:@"请输入密码"] show];
        return;
    }
    
    if (!TTIsStringWithAnyText(self.repeatpasswordTextField.text)) {//密码为空
        [Common showText:@"请再次输入密码"];

        //[[iToast makeText:@"请再次输入密码"] show];
        return;
    }
    
    
    if (![self.repeatpasswordTextField.text isEqualToString:self.passwordTextField.text])
        
    {
        [Common showText:@"两次输入密码不一致"];

        //[[iToast makeText:@"两次输入密码不一致"] show];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSString stringWithFormat:@"%@",self.userNameTextField.text] forKey:@"username"];
    [params setValue:[NSString stringWithFormat:@"%@",self.passwordTextField.text] forKey:@"password"];

    
    [XHMDataService postRequestWithURL:API_member_register params:params isShowLoading:YES successBlock:^(id result) {
        
        [Common showText:[result objectForKey:@"message"]];
        
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
