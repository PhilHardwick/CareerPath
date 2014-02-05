//
//  CPTableViewController.h
//  CareerPath
//
//  Created by Philip Hardwick on 28/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNextControllerDelegate.h"
#import "CPBaseViewController.h"

@interface CPQuestionViewController : CPBaseViewController

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutlet UIButton *yesButton;
@property (strong, nonatomic) IBOutlet UIButton *noButton;

- (IBAction)noButtonTapped:(id)sender;
- (IBAction)yesButtonTapped:(id)sender;

@end
