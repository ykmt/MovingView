//
//  NavigationProtocol.h
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NavigationProtocol <NSObject>

@required
- (void)setShopDrawerEnabled:(BOOL)enabled;

@optional
- (void)openMenuDrawer;
- (void)openMenuDrawerWithAnimation:(BOOL)animation;
- (void)openShopDrawer;
- (void)openShopDrawerWithAnimation:(BOOL)animation;
- (void)closeDrawer;
- (void)closeDrawerWithAnimation:(BOOL)animation;
- (void)closeDrawerWithAnimation:(BOOL)animation completion:(void(^)(BOOL finished))completion;

@end
