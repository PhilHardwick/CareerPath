//
//  CPBaseViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPBaseViewController.h"
#import "CPAppDelegate.h"
#import "CPQuestionViewController.h"

@interface CPBaseViewController ()

@end

@implementation CPBaseViewController

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
	self.nextControllerDelegate = ((CPAppDelegate *)[UIApplication sharedApplication].delegate).nextController;
    UIImage *backButtonImage = [UIImage imageNamed:@"backButton"];
}

- (void)goToStartViewController:(id)sender; {
    [self.nextControllerDelegate viewControllerAsksForFirstController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonTapped:(id)sender {
    self.response = CPPreviousQuestionResponseNone;
    [self.nextControllerDelegate viewControllerAsksForNextController:self];
}

@end
