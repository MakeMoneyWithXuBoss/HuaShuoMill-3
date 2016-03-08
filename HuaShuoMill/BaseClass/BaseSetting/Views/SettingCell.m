//
//  SettingCell.m
//  Weibo
//
//  Created by ios_ysj on 14/11/29.
//  Copyright (c) 2014年 ___XuHuiMing___. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
#import "SettingTextFieldItem.h"
#import "SettingHeadArrowItem.h"
#import "SettingLabelArrowItem.h"

#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define kVersion [[UIDevice currentDevice].systemVersion floatValue]


/** 字标题的字体 */
#define titleContentFont [UIFont systemFontOfSize:14]
/** 箭头的位置  */
#define arrowFrameX 200-16

//cell.txtTitle.textColor = RGBCOLOR(86, 106, 115);
//cell.txtIntro.textColor = RGBCOLOR(165, 165, 165);

#define titleContentColor RGBCOLOR(165, 165, 165)

@interface SettingCell()<UITextFieldDelegate>

/**
 *  箭头
 */
@property(nonatomic,strong)UIImageView *arrowView;

/**
 *  开关
 */
@property(nonatomic,strong)UISwitch *switchView;

/**
 *  文本框
 */
@property(nonatomic,strong)UITextField *textField;

/**
 *  右边Lalbe
 */
@property(nonatomic,strong)UILabel *subTitleLabel;

/**
 *  右边头像
 */
@property(nonatomic,strong)UIImageView *headView;

@property(nonatomic,strong)UIView *accessoryContentView;


@property(nonatomic,weak)UITableView *tableView;


@property (nonatomic, weak) UIView *divider;

@end
@implementation SettingCell
/**
 *  开关
 *
 *  @return
 */
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        _switchView.userInteractionEnabled = NO;
        _switchView.offImage = [UIImage imageNamed:@"switch_off.png"];
        _switchView.onImage = [UIImage imageNamed:@"switch_on.png"];
    }
    return _switchView;
}

/**
 *  箭头
 *
 *  @return
 */
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_arrow"]];
        _arrowView.contentMode = UIViewContentModeCenter;
    }
    return _arrowView;
}

/**
 *  文本框
 *
 *  @return
 */
- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = titleContentColor;
        _textField.font = titleContentFont;
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.frame = CGRectMake(0, 0, 190, self.frame.size.height);
    }
    return _textField;
}

/**
 *  UILabel
 *
 *  @return return value description
 */
- (UILabel *)subTitleLabel
{
    
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textColor = titleContentColor;
        _subTitleLabel.font = titleContentFont;
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _subTitleLabel;
}

/**
 *
 *
 *  @return <#return value description#>
 */
- (UIView *)accessoryContentView
{
    if (_accessoryContentView == nil) {
        _accessoryContentView = [[UIView alloc] init];
        _accessoryContentView.frame = CGRectMake(0, 0, 200, self.frame.size.height);
        _accessoryContentView.backgroundColor = [UIColor clearColor];
    }

    return _accessoryContentView;
}

- (UIImageView *)headView
{
    if (_headView == nil) {
        _headView = [[UIImageView alloc] init];
    }
    return _headView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identify = @"settingCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.tableView = tableView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 1.初始化背景
        [self setupBg];
        
        // 2.初始化子控件
        [self setupSubviews];
        
        // 3.初始化分割线
        if (kVersion < 7.0) {
            [self setupDivider];
        }
        
    }
    
    return self;
}

/**
 *  初始化背景
 */
- (void)setupBg
{
    // 设置普通背景
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bg;
    
    // 设置选中时的背景
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor =   RGBColor(239,239,244);
    self.selectedBackgroundView = selectedBg;
}
/**
 *  初始化子控件
 */
- (void)setupSubviews
{
    
    //标题
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = RGBCOLOR(86, 106, 115);
    //self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

/**
 *  初始化分割线
 */
- (void)setupDivider
{
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

#pragma mark - 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect newFrame = [textField convertRect:textField.frame toView:self.tableView];
    
    if (newFrame.origin.y > 260) {
        [self.tableView setContentOffset:CGPointMake(0, newFrame.origin.y-100) animated:YES];

    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    SettingTextFieldItem *settingTextFieldItem = (SettingTextFieldItem *)self.settingItem;
    
    if (settingTextFieldItem.textFieldItemOperation != nil) {
        if (TTIsStringWithAnyText(textField.text)) {
            settingTextFieldItem.textFieldItemOperation(textField.text);
            
        }
    }
    settingTextFieldItem.textTitle = textField.text;
    
}


- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
 
}


//- (void)setFrame:(CGRect)frame
//{
//    //if (kVersion < 7.0) {
//    //    CGFloat padding = 10;
//    //    frame.size.width += padding * 2;
//    //    frame.origin.x = -padding;
//    //}
//    
//    CGFloat padding = 10;
//    frame.size.width -= padding * 2;
//    frame.origin.x = padding;
//    
//    [super setFrame:frame];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, size.width,self.textLabel.frame.size.height);
    
    
    //for(UIView *view in self.subviews) {
    //#if TARGET_IPHONE_SIMULATOR
    //    Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
    //    if ([view isKindOfClass:class]) {
    //        view.left = 0;
    //        view.height = 0.5;
    //        view.width = self.width;
    //    }
    //#else
    //    for (UIView *subView in view.subviews) {
    //        Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
    //        if ([subView isKindOfClass:class]) {
    //            subView.left = 0;
    //            subView.height = 0.5;
    //            subView.width = self.width;
    //        }
    //    }
    //#endif
    //    
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    //        
    //        Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
    //        if ([view isKindOfClass:class]) {
    //            view.left = 0;
    //            view.height = 0.5;
    //            view.width = self.width;
    //        }
    //    }else{
    //        
    //        for (UIView *subView in view.subviews) {
    //            Class class = NSClassFromString(@"_UITableViewCellSeparatorView");
    //            if ([subView isKindOfClass:class]) {
    //                subView.left = 0;
    //                subView.height = 0.5;
    //                subView.width = self.width;
    //            }
    //        }
    //    }
    //    
    //}
}

- (void)setSettingItem:(SettingItem *)settingItem
{
    _settingItem = settingItem;
    
    //1.设置数据
    [self setupData];
    
    
    for (UIView *view in self.accessoryContentView.subviews) {
        [view removeFromSuperview];
    }
    
    //2.设置右边的控件
    [self setupRightContent];
}

/**
 *  设置数据
 */
- (void)setupData
{
    //1.图标
    if(self.settingItem.icon){
        self.imageView.image = [UIImage imageNamed:self.settingItem.icon];
    }
    
    //2.标题
    self.textLabel.text = self.settingItem.title;
    
    //3.子标题
    //self.detailTextLabel.text = self.settingItem.subtitle;
    
}

/**
 *  设置右边的内容
 */
- (void)setupRightContent
{
    
    if ([self.settingItem isMemberOfClass:[SettingArrowItem class]]) {
        self.accessoryView = self.arrowView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if([self.settingItem isMemberOfClass:[SettingTextFieldItem class]]){//右边文本框
        
        SettingTextFieldItem *textFieldItem = (SettingTextFieldItem *)self.settingItem;
        [self.accessoryContentView addSubview:self.textField];
        //创建视图
        self.accessoryView = self.accessoryContentView;
        
        
        //填充数据
        self.textField.text = textFieldItem.textTitle;
        if ([textFieldItem.placeholderText length] > 0) {
            self.textField.placeholder = textFieldItem.placeholderText;
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if([self.settingItem isMemberOfClass:[SettingHeadArrowItem class]]){//右边图像
        
        for (UIView *view in self.accessoryView.subviews) {
            [view removeFromSuperview];
        }

        SettingHeadArrowItem *headArrowItem = (SettingHeadArrowItem *)self.settingItem;
        //for (UIView *view in self.accessoryView.subviews) {
        //    [view removeFromSuperview];
        //}
        [self.accessoryContentView addSubview:self.headView];
        
        self.headView.frame = CGRectMake(158, 6, 32, 32);
        
        if (headArrowItem.isDisplayArrow) {//是否显示右边箭头
            [self.accessoryContentView addSubview:self.arrowView];
        }
        self.arrowView.frame = CGRectMake(arrowFrameX, 6,32, 32);
        
        //创建视图
        self.accessoryView = self.accessoryContentView;
        
        //填充数据
        self.headView.image = headArrowItem.headImage;
        
        if (headArrowItem.urlString != nil) {
            [self.headView setImageWithURL:headArrowItem.urlString placeholderImage: headArrowItem.headImage];
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        
    }else if([self.settingItem isMemberOfClass:[SettingLabelArrowItem class]]){//右边图像
        
        for (UIView *view in self.accessoryView.subviews) {
            [view removeFromSuperview];
        }
        
        SettingLabelArrowItem *labelArrowItem = (SettingLabelArrowItem *)self.settingItem;
        
        //for (UIView *view in self.accessoryView.subviews) {
        //    [view removeFromSuperview];
        //}
        
        //右边Label
        [self.accessoryContentView addSubview:self.subTitleLabel];
        self.subTitleLabel.frame = CGRectMake(0, 0, 190, self.frame.size.height);
        
        //右边箭头
        if (labelArrowItem.isDisplayArrow) {//sh
            [self.accessoryContentView addSubview:self.arrowView];
        }
        
        self.arrowView.frame = CGRectMake(arrowFrameX-3, 6,32, 32);
        
        //创建视图
        self.accessoryView = self.accessoryContentView;
        
        //填充数据
        self.subTitleLabel.text = labelArrowItem.subtitle;
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        
    }else if([self.settingItem isMemberOfClass:[SettingLabelItem class]]){
        
        SettingLabelItem *labelArrowItem = (SettingLabelItem *)self.settingItem;
        self.accessoryView = self.subTitleLabel;
        self.subTitleLabel.frame = CGRectMake(0, 0, 200, self.frame.size.height);
        self.subTitleLabel.text = labelArrowItem.subtitle;
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if([self.settingItem isKindOfClass:[SettingSwitchItem class]]){
        
        SettingSwitchItem *switchItem = (SettingSwitchItem *)self.settingItem;
        //关打开还是关闭
        [self.switchView setOn:switchItem.isOpen animated:NO];
        
        self.accessoryView = self.switchView;
        
        self.selectionStyle = UITableViewCellAccessoryNone;
    }else{
        
        self.accessoryView = nil;
        self.accessoryContentView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

+ (float)cellHeightWithData:(SettingItem*)data
{
    return 44;
}
@end
