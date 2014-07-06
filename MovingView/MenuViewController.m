//
//  MenuViewController.m
//  MovingView
//
//  Created by ykmt on 2014/07/06.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "MenuViewController.h"
#import "EmbedMenuDrawerViewController.h"
#import "MenuDataSource.h"


@interface MenuViewController () <UITableViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UITableView *menuTableVIew;
@property (strong, nonatomic) MenuDataSource *menuDataSource;
@end

@implementation MenuViewController


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    NSLog(@"%@", [self.menuDataSource menuDataWithIndexPath:indexPath]);

    [self.menuDrawerVC.appVC closeDrawerWithAnimation:YES
                                           completion:^(BOOL finished){
                                            
                                               NSLog(@"%s", __PRETTY_FUNCTION__);
                                           
                                           }];
}


#pragma mark - View Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.menuDataSource = [MenuDataSource new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.menuTableVIew.dataSource = self.menuDataSource;
    self.menuTableVIew.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view layoutSubviews];
}

@end
