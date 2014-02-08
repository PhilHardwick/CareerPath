//
//  CPUnemploymentViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 03/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPUnemploymentViewController.h"
#import "CPAPIClient.h"
#import "keys.h"

@interface CPUnemploymentViewController () {
    NSString *agebandId;
    NSArray *filterNames;
}

@end

@implementation CPUnemploymentViewController

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
	[self getAgeBand];
}

-(void)getUnemploymentRateWithNumberOfFilters:(int)numOfFilters {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *filterComponents = @[@{@"filterName":@"ageband",@"filterData":agebandId},@{@"filterName":@"region",@"filterData":[defaults objectForKey:KEY_REGION][@"code"]},@{@"filterName":@"gender",@"filterData":[defaults objectForKey:KEY_GENDER][@"code"]}];
    NSString *filters = [self getFilterStringFromArray:filterComponents usingNumberOfComponents:numOfFilters];
    [[CPAPIClient sharedInstance] GET:@"lfs/unemployment" parameters:@{@"soc":[defaults objectForKey:KEY_JOB][@"soc"],@"filterBy":filters} success:^(AFHTTPRequestOperation *operation, id response){
        NSDictionary *responseDict = (NSDictionary *)response;
        if (responseDict[@"error"] != nil) {
            [self getUnemploymentRateWithNumberOfFilters:(numOfFilters-1)];
            return;
        }
        NSArray *years = responseDict[@"years"];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *text = [NSString stringWithFormat:@"The unemployment rate for %@", [defaults objectForKey:KEY_JOB][@"title"]];
        for (NSDictionary *year in years) {
            text = [text stringByAppendingFormat:@" in %@ was %@%%",year[@"year"], year[@"unemprate"]];
        }
        text = [text stringByAppendingString:@"\n\nThe national average of unemployment is 7%, so you can see for yourself whether this is high or low compared to the rest of the country and how likely you are to be able to move jobs without competition."];
        [self.resultLabel setText:text];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [self getUnemploymentRateWithNumberOfFilters:(numOfFilters-1)];
        NSLog(@"error: %@", error);
    }];
}

- (void)getAgeBand {
    [[CPAPIClient sharedInstance] GET:@"lfs/filters/info/ageband" parameters:nil success:^(AFHTTPRequestOperation *operation, id response){
        int usersAge = [[[NSUserDefaults standardUserDefaults] objectForKey:KEY_AGE] intValue];
        NSDictionary *responseDict = (NSDictionary *)response;
        NSArray *agebands = responseDict[@"coding"];
        for (NSDictionary *agebandObj in agebands) {
            NSString *agebandDesc = agebandObj[@"description"];
            NSArray *upperAndLowerLimits = [agebandDesc componentsSeparatedByString:@" to "];
            if (upperAndLowerLimits.count > 1) {
                if (usersAge >= [upperAndLowerLimits[0] intValue] && usersAge <= [upperAndLowerLimits[1] intValue]) {
                    agebandId = agebandObj[@"code"];
                    break;
                }
            }
            //TODO deal with over 65s and under 16s
        }
        [self getUnemploymentRateWithNumberOfFilters:3];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}

- (NSString *)getFilterStringFromArray:(NSArray *)components usingNumberOfComponents:(int)num {
    NSString *filterString = @"";
    for (int x = 0; x < num; x++) {
        filterString = [filterString stringByAppendingFormat:@"%@:%@|", components[x][@"filterName"], components[x][@"filterData"]];
    }
    return filterString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
