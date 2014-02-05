//
//  CPBaseViewController.h
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPNextControllerDelegate.h"

@interface CPBaseViewController : UIViewController

@property (weak, nonatomic) id<CPNextControllerDelegate> nextControllerDelegate;

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)nextButtonTapped:(id)sender;

@end
