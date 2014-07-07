//
//  ViewController.m
//  MovingView
//
//  Created by ykmt on 2014/07/05.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "ViewController.h"
#import "EmbedMenuDrawerViewController.h"
#import "EmbedShopDrawerViewController.h"
#import "MovingViewController.h"
#import "NavigationProtocol.h"

@interface ViewController ()
{
    BOOL    _shopDrawerOpenable;
    
    BOOL    _drawerAnimating;
    BOOL    _swiping;
    
    BOOL    _isMenuDrawerOpen;
    BOOL    _isShopDrawerOpen;
    BOOL    _blockPanningLeft;
    BOOL    _blockPanningRight;
}
@property (weak, nonatomic) IBOutlet UIView *movingContainer;
@property (weak, nonatomic) IBOutlet UIView *menuDrawerContainer;
@property (weak, nonatomic) IBOutlet UIView *shopDrawerContainer;

@property (strong, nonatomic) MovingViewController          *movingVC;
@property (strong, nonatomic) EmbedMenuDrawerViewController *embedMenuDrawerVC;
@property (strong, nonatomic) EmbedShopDrawerViewController *embedShopDrawerVC;
@end


#define DRAWER_DURATION 0.2
#define DRAWER_OFFSET   80.0
#define CENTER_OFFSET   100.0


@implementation ViewController


#pragma mark - Navigation Protocol


- (void)setShopDrawerEnabled:(BOOL)enabled
{
    _shopDrawerOpenable = enabled;
}


- (void)openMenuDrawerWithAnimation:(BOOL)animation
{
    void (^animations)() = ^(){
        CGFloat x = CGRectGetWidth(self.movingContainer.frame) + DRAWER_OFFSET;
        CGPoint center = CGPointMake(x, self.movingContainer.center.y);
        self.movingContainer.center = center;

        CGRect frame = self.menuDrawerContainer.frame;
        frame.origin.x = 0.0;
        self.menuDrawerContainer.frame = frame;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        [self.movingContainer layoutSubviews];
        _isMenuDrawerOpen = YES;
        [self.movingVC setTapGestureEnable:YES];
    };
    
    if (animation)
    {
        [UIView animateWithDuration:DRAWER_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             animations();
                         }
                         completion:^(BOOL finished){
                             completion(finished);
                         }];
    }
    else
    {
        animations();
        completion(YES);
    }
}

- (void)openMenuDrawer
{
    [self openMenuDrawerWithAnimation:YES];
}


- (void)openShopDrawerWithAnimation:(BOOL)animation
{
    void (^animations)() = ^() {
        CGFloat x = -CENTER_OFFSET;
        CGPoint center = CGPointMake(x, self.movingContainer.center.y);
        self.movingContainer.center = center;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        [self.movingContainer layoutSubviews];
        _isShopDrawerOpen = YES;
        [self.movingVC setTapGestureEnable:YES];
    };
    
    if (animation)
    {
        [UIView animateWithDuration:DRAWER_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             animations();
                         }
                         completion:^(BOOL finished){
                             completion(finished);
                         }];
    }
    else
    {
        animations();
        completion(YES);
    }
}


- (void)openShopDrawer
{
    [self openShopDrawerWithAnimation:YES];
}


- (void)closeDrawerWithAnimation:(BOOL)animation completion:(void(^)(BOOL finished))completion
{
    void (^animations)() = ^() {
        CGFloat x = CGRectGetWidth(self.movingContainer.bounds)/2.0;
        CGPoint center = CGPointMake(x, self.movingContainer.center.y);
        self.movingContainer.center = center;
        
        CGRect frame = self.menuDrawerContainer.frame;
        frame.origin.x = -DRAWER_OFFSET;
        self.menuDrawerContainer.frame = frame;
    };
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        [self.movingContainer layoutSubviews];
        _isMenuDrawerOpen = NO;
        _isShopDrawerOpen = NO;
        [self.movingVC setTapGestureEnable:NO];
        
        if (completion != NULL)
        {
            completion(finished);
        }
    };
    
    if (animation)
    {
        [UIView animateWithDuration:DRAWER_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             animations();
                         }
                         completion:^(BOOL finished){
                             completionBlock(finished);
                         }];
    }
    else
    {
        animations();
        completionBlock(YES);
    }
}


- (void)closeDrawerWithAnimation:(BOOL)animation
{
    [self closeDrawerWithAnimation:animation completion:NULL];
}

- (void)closeDrawer
{
    [self closeDrawerWithAnimation:YES];
}


#pragma mark - Moving View Protocol

- (void)moveToPoint:(CGPoint)point
           velocity:(CGPoint)velocity
              state:(UIGestureRecognizerState)state
{
    if (state == UIGestureRecognizerStateBegan)
    {
        [self p_startMovingFromPoint:point withVelocity:velocity];
    }
    else if (state == UIGestureRecognizerStateChanged)
    {
        [self p_keepMovingToPoint:point withVelocity:velocity];
    }
    else if (state == UIGestureRecognizerStateEnded)
    {
        [self p_endMovingAtPoint:point withVelocity:velocity];
    }
}


#pragma mark - Private

- (void)p_startMovingFromPoint:(CGPoint)point withVelocity:(CGPoint)velocity
{
    if (velocity.x < 0.0 && !_shopDrawerOpenable) return;
    if (velocity.x > MOVING_VIEW_PROTOCOL_VELOCITY && fabs(velocity.y) < MOVING_VIEW_PROTOCOL_VELOCITY)
    {
        // 右方向にパン
        if (_isShopDrawerOpen)
        {
            _drawerAnimating = YES;
            _swiping = YES;
            [self closeDrawer];
            return;
        }
        else
        {
            _swiping = YES;
            [self openMenuDrawer];
            return;
        }
    }
    else if (velocity.x < -MOVING_VIEW_PROTOCOL_VELOCITY && fabs(velocity.y) < MOVING_VIEW_PROTOCOL_VELOCITY)
    {
        // 左方向にパン
        if (_isMenuDrawerOpen)
        {
            _drawerAnimating = YES;
            _swiping = YES;
            [self closeDrawer];
            return;
        }
        else
        {
            _swiping = YES;
            [self openShopDrawer];
            return;
        }
    }
    _drawerAnimating = NO;
    _swiping = NO;
}


- (void)p_keepMovingToPoint:(CGPoint)point withVelocity:(CGPoint)velocity
{
    if (velocity.x < 0.0 && !_shopDrawerOpenable) return;
    
    CGFloat movingX = self.movingContainer.center.x + point.x;
    
    const CGFloat MOVING_X_MIN = - DRAWER_OFFSET;
    const CGFloat MOVING_X_MAX = CGRectGetWidth(self.movingContainer.frame) + DRAWER_OFFSET;
    const CGFloat CONTAINER_CENTER_X = CGRectGetWidth(self.movingContainer.frame) / 2.0;
    
    if (!_drawerAnimating && movingX >= MOVING_X_MIN && movingX <= MOVING_X_MAX)
    {
        if ((_blockPanningRight && movingX < CONTAINER_CENTER_X) ||
            (_blockPanningLeft && movingX > CONTAINER_CENTER_X))
        {
            return;
        }
        
        if (movingX < CONTAINER_CENTER_X && !_blockPanningLeft)
        {
            [self.view insertSubview:_shopDrawerContainer belowSubview:_movingContainer];
            
            // 左側へのパンを抑制する
            _blockPanningLeft = YES;
        }
        else if (movingX > CONTAINER_CENTER_X && !_blockPanningRight)
        {
            [self.view insertSubview:_menuDrawerContainer belowSubview:_movingContainer];
            
            // 右側のパンを抑制する
            _blockPanningRight = YES;
        }
        
        
        CGPoint moveTo = CGPointMake(movingX, self.movingContainer.center.y);
        self.movingContainer.center = moveTo;
        [self.movingContainer layoutSubviews];
        

        CGFloat h = (DRAWER_OFFSET / (CGRectGetWidth(self.movingContainer.bounds) - DRAWER_OFFSET));
        CGFloat moving = h * point.x + self.menuDrawerContainer.center.x;
        CGPoint move = CGPointMake(moving, self.menuDrawerContainer.center.y);
        self.menuDrawerContainer.center = move;
        [self.menuDrawerContainer layoutSubviews];
}
}

- (void)p_endMovingAtPoint:(CGPoint)point withVelocity:(CGPoint)velocity
{
    if (velocity.x < 0.0 && !_shopDrawerOpenable) return;
    
    CGFloat centerX = self.movingContainer.center.x;
    
    
    _blockPanningLeft = NO;
    _blockPanningRight = NO;
    
    
    if (_drawerAnimating)
    {
//        [self closeDrawer]; // 動作がおかしくなったらコメントを外す
        _drawerAnimating = NO;
        return;
    }

    if (_swiping)
    {
        _swiping = NO;
        return;
    }
    
    // |- 40.0 - 160.0 - 290.0 -|
    
    if (centerX > 290.0)
    {
        // menuを開く
        [self openMenuDrawer];
    }
    else if (centerX > 160.0 && centerX <= 290.0)
    {
        // 閉じる
        [self closeDrawer];
    }
    else if (centerX > 40.0 && centerX <= 160.0)
    {
        // 閉じる
        [self closeDrawer];
    }
    else if (centerX <= 40.0)
    {
        // shopを開く
        [self openShopDrawer];
    }
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
    
    _shopDrawerOpenable = YES;
    _isMenuDrawerOpen = NO;
    _isShopDrawerOpen = NO;
    
    CGRect menuDrawerContainerRect = _menuDrawerContainer.frame;
    menuDrawerContainerRect.origin.x = -DRAWER_OFFSET;
    _menuDrawerContainer.frame = menuDrawerContainerRect;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"MovingVCSegue"])
    {
        self.movingVC = segue.destinationViewController;
        _movingVC.parentVC = self;
        [_movingVC setTapGestureEnable:NO];
    }
    else if ([identifier isEqualToString:@"EmbedMenuDrawerSegue"])
    {
        self.embedMenuDrawerVC = segue.destinationViewController;
        _embedMenuDrawerVC.appVC = self;
        
    }
    else if ([identifier isEqualToString:@"EmbedShopDrawerSegue"])
    {
        self.embedShopDrawerVC = segue.destinationViewController;
    }
    
    
    [super prepareForSegue:segue sender:sender];
}

@end
