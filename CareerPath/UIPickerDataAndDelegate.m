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

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.array objectAtIndex:row];
}


@end
