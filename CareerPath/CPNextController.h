//
//  CPNextController.h
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPNextControllerDelegate.h"
#import "CPReplaceSegueMovementDelegate.h"

@interface CPNextController : NSObject <CPNextControllerDelegate> {
    @public
    int questionId;
    NSString *nextStoryboardId;
    NSString *nextQuestion;
    NSString *nextPositiveResponse;
    NSString *nextNegativeResponse;
}

@property (nonatomic, weak) id<CPReplaceSegueMovementDelegate> movementDelegate;

@end
