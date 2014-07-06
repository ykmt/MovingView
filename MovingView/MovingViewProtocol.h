//
//  MovingViewProtocol.h
//  MovingView
//
//  Created by ykmt on 2014/07/05.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MOVING_VIEW_PROTOCOL_VELOCITY 400.0

@protocol MovingViewProtocol <NSObject>

- (void)moveToPoint:(CGPoint)point velocity:(CGPoint)velocity state:(UIGestureRecognizerState)state;

@end
