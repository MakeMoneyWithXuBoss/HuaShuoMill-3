//
//  UnReadCountLabel.m
//  HuaShuoMill
//
//  Created by XuHuiMing on 15/10/26.
//  Copyright © 2015年 XinWo. All rights reserved.
//

#import "UnReadCountLabel.h"

@implementation UnReadCountLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:11];
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.hidden = YES;
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)setCount:(int)count
{
    _count = count;
    
    NSString *tmpStr = [NSString stringWithFormat:@"%i", (int)_count];
    if (_count > 99) {
         tmpStr = @" 99+ ";
    }
    //CGSize size = [tmpStr sizeWithFont:self.font constrainedToSize:CGSizeMake(50, 20) lineBreakMode:NSLineBreakByWordWrapping];
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil];
    CGSize size = [tmpStr boundingRectWithSize:CGSizeMake(50, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    CGRect rect = self.frame;
    
    rect.size.width = size.width > 20 ? size.width : 20;
    self.text = tmpStr;
    self.frame = rect;
    self.hidden = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
