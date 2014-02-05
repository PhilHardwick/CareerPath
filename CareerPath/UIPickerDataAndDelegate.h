//
//  UIPickerDataAndDelegate.h
//  ContactCollect
//
//  Created by Philip Hardwick on 17/10/2013.
//  Copyright (c) 2013 Philip Hardwick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPickerDataAndDelegate : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@property (retain, nonatomic) NSArray *array;

-(id)initWithArray:(NSArray *)arrayToAppearInPicker;

@end
