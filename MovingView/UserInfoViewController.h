//
//  UserInfoViewController.h
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmbedMenuDrawerViewController;
@protocol NavigationProtocol;

@interface UserInfoViewController : UIViewController

@property (weak, nonatomic) id <NavigationProtocol> menuDrawerVC;

@end
