//
//  TabBarButton.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/10/26.
//  Copyright © 2015年 XinWo. All rights reserved.
//

#import "TabBarButton.h"

#import "UnReadCountLabel.h"
// 图标的比例
#define TabBarButtonImageRatio 0.46

@interface TabBarButton()

@property(nonatomic,strong)UnReadCountLabel *unReadCountLabel;

@property(nonatomic,strong)UIView *redPointView;

@end

@implementation TabBarButton

- (UIView *)redPointView
{
    if (_redPointView == nil) {
        _redPointView = [[UIView alloc]  initWithFrame:CGRectMake(self.bounds.size.width - 20-17, 2, 10, 10)];
        _redPointView.backgroundColor = [UIColor redColor];
        _redPointView.layer.masksToBounds = YES;
        _redPointView.layer.cornerRadius = 5;
        _redPointView.hidden = YES;
        
        [self addSubview:_redPointView];
    }
    return _redPointView;
}

- (UnReadCountLabel *)unReadCountLabel
{
    if (_unReadCountLabel == nil) {
        
        //小红点
        _unReadCountLabel = [[UnReadCountLabel alloc]  initWithFrame:CGRectMake(self.bounds.size.width - 20-17, 2, 20, 20)];
        _unReadCountLabel.backgroundColor = [UIColor redColor];
        _unReadCountLabel.textColor = [UIColor whiteColor];
        _unReadCountLabel.font = [UIFont systemFontOfSize:11.0];
        _unReadCountLabel.textAlignment = NSTextAlignmentCenter;
        _unReadCountLabel.layer.masksToBounds = YES;
        _unReadCountLabel.layer.cornerRadius = 10;
        //_unReadCountLabel.hidden = YES;
    }
    
    return _unReadCountLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.unReadCountLabel.hidden = YES;
        [self addSubview:self.unReadCountLabel];
        
    }
    
    return self;
}


- (void)setHighlighted:(BOOL)highlighted{}

- (void)setRedLabelNum:(int)redLabelNum {
    if (redLabelNum > 0) {
        self.redPointView.hidden = YES;
        self.unReadCountLabel.hidden = NO;
        self.unReadCountLabel.count = redLabelNum;
        
    } else {
        self.unReadCountLabel.hidden = YES;
        self.redPointView.hidden = YES;
    }
}

- (void)setIsShowRedPoint:(BOOL)isShowRedPoint
{
    _isShowRedPoint = isShowRedPoint;
    
    if (_isShowRedPoint) {
        self.redPointView.hidden = NO;
        self.unReadCountLabel.hidden = YES;
    }else{
        self.unReadCountLabel.hidden = YES;
        self.redPointView.hidden = YES;
    }
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 5;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * TabBarButtonImageRatio ;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height *(1- TabBarButtonImageRatio);
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height *TabBarButtonImageRatio;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    self.unReadCountLabel.frame = CGRectMake(self.bounds.size.width - 28, 2, self.unReadCountLabel.width, 20);
    
    if (self.isShowRedPoint) {
        self.redPointView.frame = CGRectMake(self.bounds.size.width -25, 5, 10, 10);
    }
}

@end
