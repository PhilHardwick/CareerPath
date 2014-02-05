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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)noButtonTapped:(id)sender
{
    [self answeredWithResponse:NO];
}

- (IBAction)yesButtonTapped:(id)sender
{
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
