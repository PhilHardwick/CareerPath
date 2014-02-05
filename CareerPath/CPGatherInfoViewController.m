//
//  CPGatherInfoViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPGatherInfoViewController.h"
#import "CPAPIClient.h"
#import "UIPickerDataAndDelegate.h"
#import "keys.h"

@interface CPGatherInfoViewController () {
    NSArray *jobs;
    NSDictionary *regions;
    UIPickerDataAndDelegate *regionsPickerDatasource;
    UITextField *activeField;
}

@end

@implementation CPGatherInfoViewController

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
	[self getRegions];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
        
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchApiForJobTitles];
}

-(void)searchApiForJobTitles {
    [[CPAPIClient sharedInstance] GET:@"soc/search" parameters:@{@"q":self.jobSearchBar.text} success:^(AFHTTPRequestOperation *operation, id response){
        jobs = (NSArray *)response;
        [self.jobPicker reloadAllComponents];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}

- (void)getRegions {
    [[CPAPIClient sharedInstance] GET:@"ess/regions" parameters:nil success:^(AFHTTPRequestOperation *operation, id response){
        regions = (NSDictionary *)response;
        regionsPickerDatasource = [[UIPickerDataAndDelegate alloc] initWithArray:[regions allKeys]];
        self.regionPicker.dataSource = regionsPickerDatasource;
        self.regionPicker.delegate = regionsPickerDatasource;
        [self.regionPicker reloadComponent:0];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return jobs.count>0?jobs.count:0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (jobs != nil) {
        return jobs[row][@"title"];
    }
    return @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:jobs[[self.jobPicker selectedRowInComponent:0]] forKey:KEY_JOB];
    [defaults setObject:self.ageTextField.text forKey:KEY_AGE];
    NSString *regionSelected = [regions allKeys][[self.regionPicker selectedRowInComponent:0]];
    [defaults setObject:@{@"code":regions[regionSelected],@"description":regionSelected} forKey:KEY_REGION];
    int selected = [self.genderSegmentedControl selectedSegmentIndex];
     [defaults setObject:@{@"code":[NSString stringWithFormat:@"%d",(selected + 1)],@"description":[self.genderSegmentedControl titleForSegmentAtIndex:selected]} forKey:KEY_GENDER];
    [self.nextControllerDelegate viewControllerAsksForNextController:self];
}
@end
