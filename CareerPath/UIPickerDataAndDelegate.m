//
//  UIPickerDataAndDelegate.m
//  ContactCollect
//
//  Created by Philip Hardwick on 17/10/2013.
//  Copyright (c) 2013 Philip Hardwick. All rights reserved.
//

#import "UIPickerDataAndDelegate.h"

@implementation UIPickerDataAndDelegate 

-(id)initWithArray:(NSArray *)arrayToAppearInPicker {
    self = [super init];
	if (self)
	{
        self.array = arrayToAppearInPicker;
	}
	return self;
}

#pragma mark
#pragma mark Picker Datasource Protocol

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.array count];
}

#pragma mark
#pragma mark Picker Delegate Protocol

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [self.array objectAtIndex:row];
//}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    CGRect frame = CGRectMake(0,0,320,40);
    pickerLabel = [[UILabel alloc] initWithFrame:frame];
    [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    [pickerLabel setBackgroundColor:[UIColor clearColor]];
    [pickerLabel setTextColor:[UIColor whiteColor]];
    [pickerLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:22.0]];
    [pickerLabel setNumberOfLines:0];
    if (self.array != nil) {
        [pickerLabel setText:self.array[row]];
    }
    return pickerLabel;
}


@end
