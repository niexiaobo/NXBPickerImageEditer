//
//  XBImagePicker.m
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "XBImagePicker.h"
@interface XBImagePicker ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> *VCtrl;

@end
@implementation XBImagePicker

#pragma mark 选择图片 按钮事件
- (void)selectImageWith:(UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate> *)VCtrl {
    self.VCtrl = VCtrl;
    [self callActionSheetView];
}

#pragma mark - 弹框
- (void)callActionSheetView {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self.VCtrl cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"打开相机", nil];
    [actionSheet showInView:self.VCtrl.view];
}

#pragma mark - 弹框点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {//从相册选择
        [self imageBtnClick];
    } else if (buttonIndex == 1) {//打开相机
        [self cameraBtnClick];
    } else {
        return;
    }
}

#pragma mark 相册
- (void)imageBtnClick {
    //相册
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.delegate = self.VCtrl;
    [self.VCtrl presentViewController:pick animated:YES completion:nil];
    
}

#pragma mark 相机
- (void)cameraBtnClick {
    //相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有相机,请从相册选取" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self.VCtrl;
    // picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self.VCtrl presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}


@end
