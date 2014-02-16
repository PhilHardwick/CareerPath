//
//  CPNextController.m
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPNextController.h"
#import "CPReplaceSegue.h"
#import "CPQuestionViewController.h"
#import <Accelerate/Accelerate.h>

@implementation CPNextController

- (id)init {
    self = [super init];
    if (self) {
        self->questionId = 0;
    }
    return self;
}

- (void)viewControllerAsksForNextController:(UIViewController *)viewController {
    CPBaseViewController *baseViewController = (CPBaseViewController *)viewController;
    [self getDataForNextController];
    UIViewController *newController = [[UIStoryboard storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:nextStoryboardId];
    if ([newController respondsToSelector:@selector(setQuestionLabel:)]) {
        [((CPQuestionViewController *)newController) setQuestion:nextQuestion];
        ((CPQuestionViewController *)newController).positiveResponse = nextPositiveResponse;
        ((CPQuestionViewController *)newController).negativeResponse = nextNegativeResponse;
        ((CPQuestionViewController *)newController).previousResponse = baseViewController.response;
    }
    CPReplaceSegueMovementDirection movementDir;
    if (baseViewController.response == CPPreviousQuestionResponseNegative) {
        movementDir = CPReplaceSegueMovementDirectionUp;
    } else if (baseViewController.response == CPPreviousQuestionResponsePositive) {
        movementDir = CPReplaceSegueMovementDirectionRight;
    } else {
        movementDir = arc4random_uniform(2)==1?CPReplaceSegueMovementDirectionRight:CPReplaceSegueMovementDirectionUp;
    }
    CPReplaceSegue *segue = [[CPReplaceSegue alloc] initWithIdentifier:@"replace" source:viewController destination:newController movementDirection:movementDir];
    [segue perform];
    if (shouldBlur == YES) {
        [self.movementDelegate segueOccuredWithDirection:movementDir andBlur:YES];
    } else {
        [self.movementDelegate segueOccuredWithDirection:movementDir andBlur:NO];
    }
}

- (void)getDataForNextController {
    NSArray *questions = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"]];
    nextQuestion = questions[questionId][@"question"];
    nextStoryboardId = questions[questionId][@"storyboardId"];
    nextPositiveResponse = questions[questionId][@"Yes"];
    nextNegativeResponse = questions[questionId][@"No"];
    shouldBlur = [questions[questionId][@"shouldBlur"] boolValue];
    questionId++;
}

- (void)viewControllerAsksForFirstController:(UIViewController *)viewController {
    self->questionId = 0;
    UIViewController *newController = [[UIStoryboard storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:@"GatherInfoController"];
    CPReplaceSegue *segue = [[CPReplaceSegue alloc] initWithIdentifier:@"replace" source:viewController destination:newController movementDirection:CPReplaceSegueMovementDirectionLeft];
    [segue perform];
    [self.movementDelegate segueOccuredBackToStart:CPReplaceSegueMovementDirectionLeft];
}



@end
