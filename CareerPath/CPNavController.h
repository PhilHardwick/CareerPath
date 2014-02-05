//
//  CPNavController.h
//  CareerPath
//
//  Created by Philip Hardwick on 28/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPReplaceSegueMovementDelegate.h"

@interface CPNavController : UINavigationController <CPReplaceSegueMovementDelegate>

@property (retain, nonatomic) UIScrollView *scrollView;

@end
