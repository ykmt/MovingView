//
//  EmbedMenuDrawerViewController.h
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationProtocol.h"

@class ViewController;

@interface EmbedMenuDrawerViewController : UIViewController <NavigationProtocol>

@property (weak, nonatomic) id <NavigationProtocol> appVC;

@end
