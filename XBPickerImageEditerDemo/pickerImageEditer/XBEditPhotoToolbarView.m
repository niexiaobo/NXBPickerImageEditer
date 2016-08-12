//
//  XBEditPhotoToolbarView.m
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "XBEditPhotoToolbarView.h"

@implementation XBEditPhotoToolbarView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.tag =  750;
        self.alpha = 0.4;
        self.layer.cornerRadius = 25;
        self.layer.masksToBounds = YES;
        [self creatBtn1];
        
    }
    return self;
}
//+按钮
- (void)creatBtn1
{
    
    UIButton *Btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [Btn1 setTitle:@"+" forState:UIControlStateNormal];
    Btn1.backgroundColor = [UIColor blackColor];
    Btn1.tag = 751;
    [Btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Btn1 addTarget:self action:@selector(Btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:Btn1];
    
}

- (void)Btn1Click:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES)
    {
        [self creatButtonView];
    }
    else
    {
        [self hidenButtonView];
    }
}

- (void)hidenButtonView
{
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = CGRectMake(20, screenHeight-70, 50, 50);
        UIButton *Btn = (UIButton *)[self viewWithTag:751];
        Btn.frame = CGRectMake(0, 0, 50, 50);
    }];
    for (int i = 0; i<4; i++)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:755+i];
        [btn removeFromSuperview];
    }
}
- (void)creatButtonView
{
    NSArray *titleArray = @[@"文字",@"直线",@"随手",@"图片",@"箭头"];
    // NSArray *imageArray = @[@"801",@"802",@"803",@"804",@"803"];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = CGRectMake(20, screenHeight-320, 50, 300);
        UIButton *Btn = (UIButton *)[self viewWithTag:751];
        Btn.frame = CGRectMake(0, 250, 50, 50);
    }];
    for (int i = 0; i<5; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 50*i+10, 30, 30);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        //[btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        btn.tag = 755+i;
        [btn addTarget:self action:@selector(toolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
- (void)toolBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 755:
            //文字
            [self.delegate  addText];
            break;
        case 756:
            //直线
            [self.delegate addLineWith:(1)];
            break;
        case 759:
            [self.delegate addLineWith:(0)];
            break;
        case 757:
            //随意划线
            [self.delegate addPike];
            break;
        case 758:
            //表情
            [self.delegate addImage];
            break;
        default:
            break;
    }
    [self hidenButtonView];
    
}

@end
