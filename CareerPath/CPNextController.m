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

@implementation CPNextController

- (id)init {
    self = [super init];
    if (self) {
        self->questionId = 0;
    }
    return self;
}

- (void)viewControllerAsksForNextController:(UIViewController *)viewController {
    CPReplaceSegueMovementDirection movementDir;
    if (arc4random()%2 == 1) {
        movementDir = CPReplaceSegueMovementDirectionUp;
    } else {
        movementDir = CPReplaceSegueMovementDirectionRight;
    }
    [self getDataForNextController];
    UIViewController *newController = [[UIStoryboard storyboardWithName:@"Main" bundle:Nil] instantiateViewControllerWithIdentifier:nextStoryboardId];
    if ([newController respondsToSelector:@selector(setQuestionLabel:)]) {
        [newController view];
        [((CPQuestionViewController *)newController).questionLabel setText:nextQuestion];
        [((CPQuestionViewController *)newController).yesButton.titleLabel setText:nextPositiveResponse];
        [((CPQuestionViewController *)newController).noButton.titleLabel setText:nextNegativeResponse];
    }
    CPReplaceSegue *segue = [[CPReplaceSegue alloc] initWithIdentifier:@"replace" source:viewController destination:newController movementDirection:movementDir];
    [segue perform];
    [self.movementDelegate segueOccuredWithDirection:movementDir];
}

- (void)getDataForNextController {
    NSArray *questions = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"]];
    nextQuestion = questions[questionId][@"question"];
    nextStoryboardId = questions[questionId][@"storyboardId"];
    nextPositiveResponse = questions[questionId][@"Yes"];
    nextNegativeResponse = questions[questionId][@"No"];
    questionId++;
}

@end
