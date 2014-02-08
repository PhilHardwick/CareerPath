//
//  CPViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 27/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPPayViewController.h"
#import "CPAPIClient.h"
#import "keys.h"

@interface CPPayViewController ()

@end

@implementation CPPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[self getPayforSOCCode:[defaults objectForKey:KEY_JOB][@"soc"] age:[defaults objectForKey:KEY_AGE]];
}


-(void)getPayforSOCCode:(NSString *)socCode age:(NSString *)age {
    [[CPAPIClient sharedInstance] GET:@"ashe/estimatePay" parameters:@{@"soc":socCode,@"age":age} success:^(AFHTTPRequestOperation *operation, id response){
        NSDictionary *responseDict = (NSDictionary *)response;
        float estPayPerWeek = [responseDict[@"series"][0][@"estpay"] doubleValue];
        float estPayPerYear = estPayPerWeek*52.0f;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [self.resultLabel setText:[NSString stringWithFormat:@"The average weekly pay for %@ is £%.2f which is £%.2f a year", [defaults objectForKey:KEY_JOB][@"title"], estPayPerWeek, estPayPerYear]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonTapped:(id)sender {
    
}
@end
