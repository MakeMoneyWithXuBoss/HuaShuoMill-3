//
//  ContactUsViewController.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/11/17.
//  Copyright © 2015年 ___XuHuiMing___QQ_543260656. All rights reserved.
//

#import "ContactUsViewController.h"

#import <MessageUI/MessageUI.h>


#import "ContactUsModel.h"
#import "ContactUsCell.h"

#import "ProductBrandViewController.h"
#import "QueryServiceCenterViewController.h"

@interface ContactUsViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>
{
    int pageindex;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ContactUsViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundColor:RGBColor(239,239,244)];
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
        
}


- (void)searchBtnClick:(UIButton *)button
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}


- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [XHMDataService getRequestWithURL:API_contact_getAll params:params isShowLoading:YES successBlock:^(id result) {
        
        [self.dataArray removeAllObjects];
        //列表数据
        NSMutableArray *categoriesArray = [result objectForKey:@"contacts"];
        for (NSMutableDictionary *collectionDic in categoriesArray) {
            ContactUsModel *contactUsModel = [[ContactUsModel alloc] initWithDic:collectionDic];
            [self.dataArray addObject:contactUsModel];
        }
        [self.tableView reloadData];
        
       
        
    } errorBlock:^(NSError *error) {
        
     
        
    }];
    
}


#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([self.dataArray count] == 0) {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建单元格
    static NSString *identify = @"BaseTableViewCell";
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    
    ContactUsModel *contactUsModel = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",contactUsModel.image]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"contact_%@",contactUsModel.type]]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",contactUsModel.title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",contactUsModel.descri];
    
    if ([contactUsModel.type isEqualToString:@"link"]) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",contactUsModel.link
                                  ];
    }
    
    //cell.contactUsModel = contactUsModel;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ContactUsModel *contactUsModel = [self.dataArray objectAtIndex:indexPath.row];
    
    if ([contactUsModel.type isEqualToString:@"phone"]) {
        
        
        NSString *number = [NSString stringWithFormat:@"%@",contactUsModel.descri];// 此处读入电话号码
        
        // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
        
    }else if ([contactUsModel.type isEqualToString:@"email"]) {
        
        NSMutableString *mailUrl = [[NSMutableString alloc]init];
        //添加收件人
        NSArray *toRecipients = [NSArray arrayWithObject: contactUsModel.descri];
        [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
        //添加抄送
        //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
        //[mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
        //添加密送
        //NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
        //[mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
        //添加主题
        //[mailUrl appendString:@""];
        //添加邮件内容
        //[mailUrl appendString:@""];
        NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
        
        
        //if (![MFMailComposeViewController canSendMail]) return;
        //MFMailComposeViewController *mfMainComposeVC = [[MFMailComposeViewController alloc] init];
        //[mfMainComposeVC setSubject:@"写邮件"];
        ////[mfMainComposeVC setMessageBody:@"今天下午开会么" isHTML:NO];
        //[mfMainComposeVC.navigationBar setTintColor:[UIColor whiteColor]];
        //mfMainComposeVC.navigationBar.barTintColor = RGBCOLOR(28, 137, 215);
        //
        //// 设置收件人列表
        //[mfMainComposeVC setToRecipients:@[contactUsModel.description]];
        //// 设置抄送人列表
        //[mfMainComposeVC setCcRecipients:@[contactUsModel.description]];
        //// 设置密送人列表
        //[mfMainComposeVC setBccRecipients:@[@"56789@qq.com"]];
        //
        //// 添加附件（一张图片）
        //UIImage *image = [UIImage imageNamed:@"lufy.png"];
        //NSData *data = UIImagePNGRepresentation(image);
        //[mfMainComposeVC addAttachmentData:data mimeType:@"image/png" fileName:@"lufy.png"];
        //// 设置代理
        //mfMainComposeVC.mailComposeDelegate = self;
        //mfMainComposeVC.navigationController.delegate = self;
        //// 显示控制器
        //[self presentViewController:mfMainComposeVC animated:YES completion:^{
        //    mfMainComposeVC.navigationBar.barTintColor = RGBCOLOR(28, 137, 215);
        //
        //    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        //
        //}];
        
    }else if ([contactUsModel.type isEqualToString:@"link"]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contactUsModel.link]];

        
    }else if ([contactUsModel.type isEqualToString:@"location"]) {
        
        QueryServiceCenterViewController *queryServiceCenterVC = [[QueryServiceCenterViewController alloc] init];
        [self.navigationController pushViewController:queryServiceCenterVC animated:YES];
        
        //NSString  *addressText = @"beijing";         addressText =[addressText stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        //NSString*urlText = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",addressText];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
        
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    navigationController.navigationBar.barTintColor = RGBCOLOR(28, 137, 215);
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


//- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
//{
//    viewControllerToPresent.navigationController.navigationBar.barTintColor = RGBCOLOR(28, 137, 215);
//    
//    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
//    
//}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
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
