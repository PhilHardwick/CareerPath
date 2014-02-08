//
//  CPNavController.m
//  CareerPath
//
//  Created by Philip Hardwick on 28/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPNavController.h"

@interface CPNavController () {
    @private
    CGPoint startOffset;
    CGPoint destinationOffset;
    NSDate *startTime;
    NSTimer *timer;
}

@end

@implementation CPNavController

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
	UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forest.jpg"]];
    CGSize size = tempImageView.frame.size;
    [self.scrollView setContentSize:tempImageView.frame.size];
    [tempImageView setContentMode:UIViewContentModeCenter];
    [self.scrollView addSubview:tempImageView];
    [self.view insertSubview:self.scrollView atIndex:0];
}

- (void)segueOccuredWithDirection:(CPReplaceSegueMovementDirection)movementDirection {
    CGPoint currentPoint = self.scrollView.contentOffset;
    switch (movementDirection) {
        case CPReplaceSegueMovementDirectionDown:
            currentPoint.y -= 80;
            break;
        case CPReplaceSegueMovementDirectionUp:
            currentPoint.y += 80;
            break;
        case CPReplaceSegueMovementDirectionRight:
            currentPoint.x += 200;
            break;
        case CPReplaceSegueMovementDirectionLeft:
            currentPoint.x -= 200;
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^(void){
        [self.scrollView setContentOffset:currentPoint];
    } completion:nil];
    //[self doAnimatedScrollTo:currentPoint];
}

- (void) animateScroll:(NSTimer *)timerParam
{
    const NSTimeInterval duration = 1.0;
    
    NSTimeInterval timeRunning = -[startTime timeIntervalSinceNow];
    NSLog(@"%f", timeRunning);
    
    if (timeRunning >= duration)
    {
        [self.scrollView setContentOffset:destinationOffset animated:YES];
        [timer invalidate];
        timer = nil;
        return;
    }
	CGPoint offset = [self.scrollView contentOffset];
	offset.x = startOffset.x + (destinationOffset.x - startOffset.x) * timeRunning / duration;
    offset.y = startOffset.y + (destinationOffset.y - startOffset.y) * timeRunning / duration;
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void) doAnimatedScrollTo:(CGPoint)offset
{
    startTime = [NSDate date];
    startOffset = self.scrollView.contentOffset;
    destinationOffset = offset;
    
    if (!timer)
    {
        timer =
		[NSTimer scheduledTimerWithTimeInterval:0.01
                                         target:self
                                       selector:@selector(animateScroll:)
                                       userInfo:nil
                                        repeats:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
