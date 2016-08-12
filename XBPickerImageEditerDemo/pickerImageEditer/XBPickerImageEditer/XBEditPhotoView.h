//
//  XBEditPhotoView.h
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBEditRectangleView.h"
@protocol XBEditPhotoDelegate <NSObject>
-(void)editPhotoViewSureCancelBtnClick:(UIButton*)SureCancelBtn;//确定按钮

@end

@interface XBEditPhotoView : UIView
@property(nonatomic,strong)UIImage *image;
@property (nonatomic, strong) XBEditRectangleView *selectView;
@property(nonatomic,strong)id<XBEditPhotoDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame andWithImage:(UIImage *)image;
#pragma mark - 裁剪selectView
- (UIImage *)graphicsEditImage;
@end
