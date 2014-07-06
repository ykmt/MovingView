//
//  EmbedShopDrawerViewController.m
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "EmbedShopDrawerViewController.h"
#import "ShopListViewController.h"

@interface EmbedShopDrawerViewController ()

@property (strong, nonatomic) ShopListViewController *shopListVC;
@end

@implementation EmbedShopDrawerViewController

#pragma mark - 

- (BOOL)p_isIOS7
{
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    return [osVersion hasPrefix:@"7"];
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

    
    self.shopListVC = [[ShopListViewController alloc] initWithNibName:@"ShopListViewController" bundle:nil];
    
    [self addChildViewController:_shopListVC];
    [_shopListVC didMoveToParentViewController:self];
    
    [self.view addSubview:_shopListVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Shop List View
    CGRect shopListRect = _shopListVC.view.frame;
    shopListRect.origin = CGPointZero;
    shopListRect.size.width = CGRectGetWidth(self.view.frame);
    
    if ([self p_isIOS7])
    {
        shopListRect.origin.y = 20.0;
        shopListRect.size.height = CGRectGetHeight(self.view.frame) - 20.0;
    }
    else
    {
        shopListRect.size.height = CGRectGetHeight(self.view.frame);
    }
    
    _shopListVC.view.frame = shopListRect;
    
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
