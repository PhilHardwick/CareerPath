//
//  CPReplaceSegue.h
//  CareerPath
//
//  Created by Philip Hardwick on 29/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CPReplaceSegueMovementDirection) {
    CPReplaceSegueMovementDirectionDown,
    CPReplaceSegueMovementDirectionUp,
    CPReplaceSegueMovementDirectionRight,
    CPReplaceSegueMovementDirectionLeft
};

@interface CPReplaceSegue : UIStoryboardSegue

@property (nonatomic) CPReplaceSegueMovementDirection movementDirection;

-(id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination movementDirection:(CPReplaceSegueMovementDirection)movementDir;

@end
