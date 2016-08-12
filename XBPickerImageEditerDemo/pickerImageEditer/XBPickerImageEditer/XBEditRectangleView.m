//
//  XBEditRectangleView.m
//  pickerImageEditer
//
//  Created by 博彦科技-聂小波 on 16/8/11.
//  Copyright © 2016年 聂小波. All rights reserved.
//

#import "XBEditRectangleView.h"
@interface XBEditRectangleView ()
@property (nonatomic, assign) CGPoint beginpoint;
@end

@implementation XBEditRectangleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 3;
        self.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.beginpoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    CGRect frame = self.frame;
    frame.origin.x += currentLocation.x - self.beginpoint.x;
    frame.origin.y += currentLocation.y - self.beginpoint.y;
    
    if (frame.origin.x + frame.size.width > self.limitFrame.size.width) {
        frame.origin.x = self.limitFrame.size.width - frame.size.width;
    }
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
    }
    
    if (frame.origin.y + frame.size.height > self.limitFrame.size.height) {
        frame.origin.y = self.limitFrame.size.height - frame.size.height;
    }
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
    }
    
    self.frame = frame;
}



@end
