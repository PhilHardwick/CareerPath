//
//  CPTableViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 28/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPQuestionViewController.h"
#import "CPReplaceSegue.h"
#import "CPNavController.h"

@interface CPQuestionViewController ()

@end

@implementation CPQuestionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.questionLabel setText:self.question];
    [self.yesButton setTitle:self.positiveResponse forState:UIControlStateNormal];
    [self.noButton setTitle:self.negativeResponse forState:UIControlStateNormal];
    switch (self.previousResponse) {
        case CPPreviousQuestionResponseNegative:
            [self.imageBackground setImage:[UIImage imageNamed:@"fromTop586"]];
            break;
        case CPPreviousQuestionResponsePositive:
            [self.imageBackground setImage:[UIImage imageNamed:@"fromSide586"]];
            break;
        case CPPreviousQuestionResponseNone:
            [self.imageBackground setImage:[UIImage imageNamed:@"noOrigin586"]];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)noButtonTapped:(id)sender
{
    self.response = CPPreviousQuestionResponseNegative;
    [self answeredWithResponse:NO];
}

- (IBAction)yesButtonTapped:(id)sender
{
    self.response = CPPreviousQuestionResponsePositive;
    [self answeredWithResponse:YES];
}

-(void)answeredWithResponse:(bool)positiveResponse
{
    [self.nextControllerDelegate viewControllerAsksForNextController:self];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
