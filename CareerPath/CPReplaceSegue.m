//
//  CPReplaceSegue.m
//  CareerPath
//
//  Created by Philip Hardwick on 29/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPReplaceSegue.h"

@implementation CPReplaceSegue

-(id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination movementDirection:(CPReplaceSegueMovementDirection)movementDir {
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        self.movementDirection = movementDir;
    }
    return self;
}

- (void)perform {
    UIViewController* source = (UIViewController *)self.sourceViewController;
    UIViewController* destination = (UIViewController *)self.destinationViewController;
    
    CGRect sourceFrame = source.view.frame;
    CGRect destFrame = destination.view.frame;
    switch (self.movementDirection) {
        case CPReplaceSegueMovementDirectionDown:
            sourceFrame.origin.y = sourceFrame.size.height;
            
            destFrame.origin.y = -destination.view.frame.size.height;
            destination.view.frame = destFrame;
            destFrame.origin.y = 0;
            break;
        case CPReplaceSegueMovementDirectionUp:
            sourceFrame.origin.y = -sourceFrame.size.height;
            
            destFrame.origin.y = destination.view.frame.size.height;
            destination.view.frame = destFrame;
            destFrame.origin.y = 0;
            break;
        case CPReplaceSegueMovementDirectionRight:
            sourceFrame.origin.x = -sourceFrame.size.width;
            
            destFrame.origin.x = destination.view.frame.size.width;
            destination.view.frame = destFrame;
            destFrame.origin.x = 0;
            break;
        case CPReplaceSegueMovementDirectionLeft:
            sourceFrame.origin.x = sourceFrame.size.width;
            
            destFrame.origin.x = -destination.view.frame.size.width;
            destination.view.frame = destFrame;
            destFrame.origin.x = 0;
            break;
            
        default:
            break;
    }
    
    
    [source.view.superview addSubview:destination.view];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         source.view.frame = sourceFrame;
                         destination.view.frame = destFrame;
                     }
                     completion:^(BOOL finished) {
                         UIWindow *window = source.view.window;
                         [((UINavigationController *)window.rootViewController) addChildViewController:destination];
                     }];
}

@end
