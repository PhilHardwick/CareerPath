//
//  CPBaseViewController.h
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNextControllerDelegate.h"

typedef NS_ENUM(NSInteger, CPPreviousQuestionResponse) {
    CPPreviousQuestionResponsePositive,
    CPPreviousQuestionResponseNegative,
    CPPreviousQuestionResponseNone,
};

@interface CPBaseViewController : UIViewController

@property (weak, nonatomic) id<CPNextControllerDelegate> nextControllerDelegate;
@property (nonatomic) CPPreviousQuestionResponse response;

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)nextButtonTapped:(id)sender;
- (IBAction)goToStartViewController:(id)sender;

@end
