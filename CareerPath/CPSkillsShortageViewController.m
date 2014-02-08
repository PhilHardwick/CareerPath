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
        NSDictionary *responseDict = (NSDictionary *)response;
        if (responseDict[@"error"] != nil) {
            [self getHardToFillVacanciesAndItsSkillsShortageAsCoarseSearch:isCoarseSearch];
            return;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *text = [NSString stringWithFormat:@"The percentage of vacancies for %@ which employers find hard to fill is %.2f%%. \n %.2f%% of those vacancies which are hard to fill are because aplicants dont have the right skills, qualifications or experience.", [defaults objectForKey:KEY_JOB][@"title"], [responseDict[@"percentHTF"] floatValue], [responseDict[@"percentHTFisSSV"] floatValue]];
        switch ([responseDict[@"percentHTF"] integerValue]) {
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
        switch ([responseDict[@"percentHTFisSSV"] integerValue]) {
            case 0 ... 33:
                text = [text stringByAppendingString:@"\n\nThe amount of hard to fill vacancies caused by a skills shortage is low and therefore most people applying for these jobs have the necessary skills and experience. If the job is also hard to fill then it's likely that it's a difficult job! If it's not then there's fierce competition and you need to bring something special to the interview to make sure you stand out."];
                break;
            case 34 ... 66:
                text = [text stringByAppendingString:@"\n\nThe amount of hard to fill vacancies caused by a skills shortage is average and therefore it's 50/50 as to whether people have the skills to do this job. Studying here, or gaining specialised experience could give you an advantage in pinning those hard to fill vacancies."];
                break;
            case 67 ... 100:
                text = [text stringByAppendingString:@"\n\nThe amount of hard to fill vacancies caused by a skills shortage is high and therefore most people applying for the hard to fill positions are underqualifed and inexperienced. Studying here and gaining specialised experience is essential to gain these top roles."];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
