//
//  CPSkillsShortageViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 05/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPSkillsShortageViewController.h"
#import "CPAPIClient.h"
#import "keys.h"
#import "CPSkillsShortagePart2ViewController.h"
#import "CPReplaceSegue.h"

@interface CPSkillsShortageViewController ()

@end

@implementation CPSkillsShortageViewController

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
	[self getHardToFillVacanciesAndItsSkillsShortageAsCoarseSearch:@"false"];
}

-(void)getHardToFillVacanciesAndItsSkillsShortageAsCoarseSearch:(NSString *)isCoarseSearch {
    [[CPAPIClient sharedInstance] GET:[NSString stringWithFormat:@"ess/uk/%@", [[NSUserDefaults standardUserDefaults] objectForKey:KEY_JOB][@"soc"]] parameters:@{@"coarse":isCoarseSearch} success:^(AFHTTPRequestOperation *operation, id response){
        self.HTFAndSSVDict = (NSDictionary *)response;
        if (self.HTFAndSSVDict[@"error"] != nil) {
            [self getHardToFillVacanciesAndItsSkillsShortageAsCoarseSearch:isCoarseSearch];
            return;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *text = [NSString stringWithFormat:@"The percentage of vacancies for %@ which employers find hard to fill is %.2f%%. \n ", [defaults objectForKey:KEY_JOB][@"title"], [self.HTFAndSSVDict[@"percentHTF"] floatValue]];
        switch ([self.HTFAndSSVDict[@"percentHTF"] integerValue]) {
            case 0 ... 20:
                text = [text stringByAppendingString:@"\n\nYour job seems to have a low percentage of hard to fill vacancies, this means it's highly desired and could mean it's tougher to get a similar job elsewhere"];
                break;
            case 21 ... 40:
                text = [text stringByAppendingString:@"\n\nYour job seems to have a average percentage of hard to fill vacancies, this means you have an average chance at finding a similar job."];
                break;
            case 41 ... 100:
                text = [text stringByAppendingString:@"\n\nYour job seems to have a high percentage of hard to fill jobs, there could be many reasons for this including low pay, long hours etc. this indicates that you could find it easier to get a new job."];
                break;
                
            default:
                break;
        }
        [self.resultLabel setText:text];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if ([isCoarseSearch isEqualToString:@"false"]) {
            [self getHardToFillVacanciesAndItsSkillsShortageAsCoarseSearch:@"true"];
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"replace"]) {
        CPSkillsShortagePart2ViewController *vc = (CPSkillsShortagePart2ViewController *)segue.destinationViewController;
        [vc setHTFAndSSVDict:self.HTFAndSSVDict];
        ((CPReplaceSegue *) segue).movementDirection = CPReplaceSegueMovementDirectionRight;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
