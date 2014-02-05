//
//  CPResponseToAnswerDelegate.h
//  CareerPath
//
//  Created by Philip Hardwick on 27/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPReplaceSegue.h"

@protocol CPReplaceSegueMovementDelegate <NSObject>

@required
-(void)segueOccuredWithDirection:(CPReplaceSegueMovementDirection)movementDirection;

@end
