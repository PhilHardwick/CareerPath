//
//  CPEndViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 15/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPEndViewController.h"

@interface CPEndViewController ()

@end

@implementation CPEndViewController

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
	// Do any additional setup after loading the view.
}

-(void)webLinkTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@", ((UIButton *)sender).titleLabel.text]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
