//
//  XBEditPhotoToolbarView.h
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XBEditPhotoToolbarDelegate <NSObject>

-(void)addText;
-(void)addLineWith:(BOOL)isLine;
-(void)addPike;
-(void)addImage;

@end

@interface XBEditPhotoToolbarView : UIView
@property(nonatomic,strong)id<XBEditPhotoToolbarDelegate> delegate;
@end
