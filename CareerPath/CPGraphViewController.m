//
//  CPGraphViewController.m
//  CareerPath
//
//  Created by Philip Hardwick on 07/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPGraphViewController.h"
#import "CPAPIClient.h"
#import "keys.h"

@interface CPGraphViewController ()

@end

@implementation CPGraphViewController

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
    [self.webView setDelegate:self];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"chart" ofType:@"html"];
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSString *htmlString = [[NSString alloc] initWithData:
                            [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    NSString *baseUrlPath = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:baseUrlPath];
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self getWorkingFuturesData];
}

- (void)getWorkingFuturesData {
    [[CPAPIClient sharedInstance] GET:@"wf/predict" parameters:@{@"soc":[[NSUserDefaults standardUserDefaults] objectForKey:KEY_JOB][@"soc"]} success:^(AFHTTPRequestOperation *operation, id response){
        NSDictionary *responseDict = (NSDictionary *)response;
        NSArray *arrayOfData = responseDict[@"predictedEmployment"];
        NSMutableArray *years = [[NSMutableArray alloc] init];
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (NSDictionary *yearOfData in arrayOfData) {
            [years addObject:yearOfData[@"year"]];
            [data addObject:yearOfData[@"employment"]];
        }
        NSString *javascriptDataString = [NSString stringWithFormat:@"var data = { labels :['%@'],                                                            datasets : [ { fillColor : 'rgba(220,220,220,0.5)', strokeColor : 'rgba(220,220,220,1)', pointColor : 'rgba(220,220,220,1)', pointStrokeColor : '#fff', data : [%@] } ] }", [years componentsJoinedByString:@"','"], [data componentsJoinedByString:@","]];
        [self.webView stringByEvaluatingJavaScriptFromString:javascriptDataString];
        [self.webView stringByEvaluatingJavaScriptFromString:@"var ctx = document.getElementById('myChart').getContext('2d');var myNewChart = new Chart(ctx).Line(data);"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self getWorkingFuturesData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
