//
//  ViewController.m
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/10.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "ViewController.h"
#import "XBEditPhotoView.h"
#import "XBImagePicker.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,XBEditPhotoDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) XBEditPhotoView *backView;
@property (nonatomic, strong) XBImagePicker *imagePicker;

@property (nonatomic, strong) UIImageView *editImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _editImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, screenWidth, 200)];
    [self.view addSubview:_editImage];
    _editImage.contentMode = UIViewContentModeScaleToFill;
    _editImage.layer.borderWidth = 1;
    _editImage.layer.borderColor = [UIColor grayColor].CGColor;
    UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth - 100)/2.0, 350, 100, 60)];
    [selectBtn setTitle:@"选择图片" forState:0];
    [selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    selectBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:selectBtn];
    
}

#pragma mark 选择图片 按钮事件
- (void)selectBtnClick {
    self.imagePicker = [[XBImagePicker alloc]init];
    [self.imagePicker selectImageWith:self];
}

#pragma mark - 弹框点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {//从相册选择
        [self.imagePicker imageBtnClick];
    } else if (buttonIndex == 1) {//打开相机
        [self.imagePicker cameraBtnClick];
    } else {
        return;
    }
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   
    //可编辑区域
    _backView = [[XBEditPhotoView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andWithImage:image];
    _backView.delegate = self;
    
    _backView.userInteractionEnabled = YES;
    _backView.center = self.view.center;
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    
}

#pragma mark -XBEditPhotoView 代理 取消 确定 按钮
- (void)editPhotoViewSureCancelBtnClick:(UIButton*)SureCancelBtn {
    if (SureCancelBtn.tag == 1) {//确定
        UIImage *uiImage = [self.backView graphicsEditImage];
        _editImage.image = uiImage;
        _editImage.width = uiImage.size.width;
        _editImage.height = uiImage.size.height;
    } else {//取消
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [_backView removeFromSuperview];
}

@end
