//
//  MovingViewController.m
//  MovingView
//
//  Created by ykmt on 2014/07/05.
//  Copyright (c) 2014年 ios.ykmtApp.com. All rights reserved.
//

#import "MovingViewController.h"
#import "MovingViewProtocol.h"
#import "MovingViewController.h"
#import "NavigationProtocol.h"

@interface MovingViewController ()
{
    
}
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@end

@implementation MovingViewController


#pragma mark - 

- (void)setTapGestureEnable:(BOOL)tapEnable
{
    self.tapGesture.enabled = tapEnable;
    self.coverView.hidden = !tapEnable;
    [self.view bringSubviewToFront:_coverView];
}


#pragma mark - Private

- (void)p_handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    [self.parentVC closeDrawer];
}

- (void)p_handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    static BOOL isVertical = NO;
    static BOOL isLandscape = NO;
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        isVertical = NO;
        isLandscape = NO;
    }
    
    CGPoint point = [recognizer translationInView:self.view];
    
    // y方向にパンし始めたら、x方向のパンを抑制する
    if (!isLandscape && (fabsf(point.y) > fabsf(point.x)))
    {
        isVertical = YES;
    }
    else
    {
        isLandscape = YES;
    }

    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        isVertical = NO;
        isLandscape = NO;
    }
    
    if (! isVertical)
    {
        [recognizer setTranslation:CGPointZero inView:self.view];
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        [self.parentVC moveToPoint:point velocity:velocity state:recognizer.state];
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

    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(p_handlePanGesture:)];
    _panGesture.maximumNumberOfTouches = 1;
    _panGesture.minimumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_panGesture];
    
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                              action:@selector(p_handleTapGesture:)];
    _tapGesture.enabled = NO;
    [self.coverView addGestureRecognizer:_tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
