//
//  XBEditPhotoView.m
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "XBEditPhotoView.h"

@interface XBEditPhotoView ()
@property (nonatomic, strong) UIView *imageBgView;

@end

@implementation XBEditPhotoView

- (instancetype)initWithFrame:(CGRect)frame andWithImage:(UIImage *)image {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self creatImageViewWith:image];
    }
    return self;
}

#pragma mark - 创建图片ImageView
- (void)creatImageViewWith:(UIImage *)image {
    if (image) {
        _imageBgView = [[UIView alloc]init];
        UIImageView *imageV = [[UIImageView alloc]init];
        
        float MaxImageH = screenHeight - 64 * 2;
        
        if (image.size.width < screenWidth) {//扁长形状
            if (image.size.height < MaxImageH) {
                imageV.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                
            } else {
                imageV.frame = CGRectMake(0, 0, image.size.width, MaxImageH);
            
            }
            
        } else {
            float MaxHWRatio = MaxImageH / screenWidth; //最大高宽比
            float imageHWRatio = image.size.height / image.size.width;//image高宽比
            if (imageHWRatio > MaxHWRatio) {
                
                imageV.frame = CGRectMake(0, 0, screenWidth, MaxImageH);
            } else {
                imageV.frame = CGRectMake(0, 0, screenWidth, imageHWRatio * screenWidth);

            }
        }
    
        [self creatBtn];
        
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.center = self.center;
        imageV.image = image;
        [self addSubview:imageV];
        
        _imageBgView.frame = imageV.frame;
        _imageBgView.center = self.center;
        _imageBgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imageBgView];
        
        [_imageBgView addSubview:self.selectView];
        self.selectView.limitFrame = _imageBgView.frame;//移动的最大范围
        
    }
}

- (void)creatBtn {
    NSArray *nameArray = @[@"取消",@"确定"];
    for (int i=0; i<nameArray.count; i++) {
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame = CGRectMake( i==0 ? 20 : screenWidth-70, 20, 50, 50) ;
        sureBtn.backgroundColor = [UIColor clearColor];
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag = i;
        [self addSubview:sureBtn];
    }
}

#pragma mark 确定按钮
- (void)sureBtnClick:(UIButton*)SureCancelBtn {
    if ([self.delegate respondsToSelector:@selector(editPhotoViewSureCancelBtnClick:)]) {
        [self.delegate editPhotoViewSureCancelBtnClick:SureCancelBtn];
    }
}

- (XBEditRectangleView*)selectView {
    if (!_selectView) {
        _selectView = [[XBEditRectangleView alloc]initWithFrame:CGRectMake(0, 0, EditRectangleViewWidth, EditRectangleViewHeight)];
    }
    return _selectView;
}

#pragma mark - 裁剪selectView
- (UIImage *)graphicsEditImage {
    //截屏
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screenWidth, self.frame.size.height), YES, 1.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //裁剪selectView
    CGImageRef img = CGImageCreateWithImageInRect(uiImage.CGImage, CGRectMake(self.selectView.x, self.imageBgView.y + self.selectView.y, self.selectView.width, self.selectView.height));
    UIImage *newImage = [UIImage imageWithCGImage:img];
    
    return newImage;
}

@end
