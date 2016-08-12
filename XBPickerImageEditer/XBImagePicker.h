//
//  XBImagePicker.h
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBImagePicker : UIView
- (void)selectImageWith:(UIViewController*)VCtrl;
#pragma mark 相册
- (void)imageBtnClick;
#pragma mark 相机
- (void)cameraBtnClick;
@end
