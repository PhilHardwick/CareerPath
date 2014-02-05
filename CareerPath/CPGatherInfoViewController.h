//
//  CPGatherInfoViewController.h
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPBaseViewController.h"

@interface CPGatherInfoViewController : CPBaseViewController <UISearchBarDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *jobSearchBar;
@property (strong, nonatomic) IBOutlet UIPickerView *jobPicker;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *regionPicker;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end
