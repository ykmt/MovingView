//
//  UserInfoViewController.m
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EmbedMenuDrawerViewController.h"
#import "NavigationProtocol.h"

@interface UserInfoViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@end

@implementation UserInfoViewController


- (IBAction)handlSwitchAction:(id)sender
{
    [self.menuDrawerVC setShopDrawerEnabled:_mySwitch.on];
}


#pragma mark - View Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
