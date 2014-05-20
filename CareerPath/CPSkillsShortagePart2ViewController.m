//
//  CPSkillsShortagePart2ViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 14/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPSkillsShortagePart2ViewController.h"

@interface CPSkillsShortagePart2ViewController ()

@end

@implementation CPSkillsShortagePart2ViewController

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
	NSString *text = [NSString stringWithFormat:@"%.2f%% of those vacancies which are hard to fill are because aplicants dont have the right skills, qualifications or experience.", [self.HTFAndSSVDict[@"percentHTFisSSV"] floatValue]];
    switch ([self.HTFAndSSVDict[@"percentHTFisSSV"] integerValue]) {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
