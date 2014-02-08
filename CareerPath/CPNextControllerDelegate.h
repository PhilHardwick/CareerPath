//
//  CPNextControllerDelegate.h
//  CareerPath
//
//  Created by Philip Hardwick on 02/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPNextControllerDelegate <NSObject>

@required
-(void)viewControllerAsksForNextController:(UIViewController *)viewController;
-(NSString *)getNextPositiveResponse;
-(NSString *)getNextNegativeResponse;

@end
