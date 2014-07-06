//
//  EmbedMenuDrawerViewController.m
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "EmbedMenuDrawerViewController.h"
#import "UserInfoViewController.h"
#import "MenuViewController.h"
#import "ViewController.h"


@interface EmbedMenuDrawerViewController ()
{
    
}
@property (strong, nonatomic) UserInfoViewController *userInfoVC;
@property (strong, nonatomic) MenuViewController     *menuVC;
@end

const CGFloat UserInfoViewHeight = 100.0;

@implementation EmbedMenuDrawerViewController


#pragma mark - Public

- (void)setShopDrawerEnabled:(BOOL)enabled
{
    [self.appVC setShopDrawerEnabled:enabled];
}


#pragma mark - Private

- (BOOL)p_isIOS7
{
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    return [osVersion hasPrefix:@"7"];
}

- (void)p_buildUserInfoViewController
{
    self.userInfoVC = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
    _userInfoVC.menuDrawerVC = self;
    
    [self addChildViewController:_userInfoVC];
    [_userInfoVC didMoveToParentViewController:self];
    
    [self.view addSubview:_userInfoVC.view];
}


- (void)p_buildMenuViewController
{
    self.menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    _menuVC.menuDrawerVC = self;
    
    [self addChildViewController:_menuVC];
    [_menuVC didMoveToParentViewController:self];
    
    [self.view addSubview:_menuVC.view];
}


#pragma mark - View Controller

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // User Info View Controller
    [self p_buildUserInfoViewController];
    
    // Menu View Controller
    [self p_buildMenuViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // User Info View
    CGRect rect = self.view.frame;
    NSLog(@"%@", NSStringFromCGRect(rect));
    
    
    UIView *userInfoVCView = _userInfoVC.view;
    CGRect userInfoRect = userInfoVCView.frame;
    userInfoRect.origin = CGPointZero;
    userInfoRect.size.width = CGRectGetWidth(rect);
    if ([self p_isIOS7])
    {
        NSLog(@"iOS7");
        userInfoRect.origin.y = 20.0;
        userInfoRect.size.height = UserInfoViewHeight;
    }
    else
    {
        NSLog(@"iOS6");
        userInfoRect.size.height = UserInfoViewHeight;
    }
    _userInfoVC.view.frame = userInfoRect;
    
    
    // Menu View
    UIView *menuVCView = _menuVC.view;
    CGRect menuRect = menuVCView.frame;
    menuRect.origin = CGPointMake(0.0, CGRectGetMaxY(userInfoRect));
    menuRect.size.height = CGRectGetHeight(self.view.frame) - CGRectGetMaxY(userInfoRect);
    menuRect.size.width = CGRectGetWidth(rect);
    _menuVC.view.frame = menuRect;

    
    [self.view layoutSubviews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
