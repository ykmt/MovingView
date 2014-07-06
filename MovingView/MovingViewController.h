//
//  MovingViewController.h
//  MovingView
//
//  Created by ykmt on 2014/07/05.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@protocol MovingViewProtocol, NavigationProtocol;

@interface MovingViewController : UIViewController

@property (weak, nonatomic) UIViewController <MovingViewProtocol, NavigationProtocol> *parentVC;

- (void)setTapGestureEnable:(BOOL)tapEnable;

@end
