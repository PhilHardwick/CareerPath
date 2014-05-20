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

@interface CPGraphViewController () {
    NSMutableArray *workingFutures;
    NSMutableDictionary *workingFuturesByQualification;
    NSMutableArray *years;
    bool allFilterIsShowing;
    UIButton *selectedButton;
}

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
    allFilterIsShowing = YES;
    [self getWorkingFuturesDataByQualifications];
}

- (void)getWorkingFuturesData {
    [[CPAPIClient sharedInstance] GET:@"wf/predict" parameters:@{@"soc":[[NSUserDefaults standardUserDefaults] objectForKey:KEY_JOB][@"soc"]} success:^(AFHTTPRequestOperation *operation, id response){
        NSDictionary *responseDict = (NSDictionary *)response;
        NSArray *array = responseDict[@"predictedEmployment"];
        years = [[NSMutableArray alloc] init];
        workingFutures = [[NSMutableArray alloc] init];
        for (NSDictionary *yearOfData in array) {
            [years addObject:yearOfData[@"year"]];
            [workingFutures addObject:yearOfData[@"employment"]];
        }
        NSString *javascriptDataString = [NSString stringWithFormat:@"var data = { labels :['%@'],                                                            datasets : [ { id : 'all', fillColor : 'rgba(220,220,220,0.5)', strokeColor : 'rgba(220,220,220,1)', pointColor : 'rgba(220,220,220,1)', pointStrokeColor : '#fff', data : [%@] } ] }", [years componentsJoinedByString:@"','"], [workingFutures componentsJoinedByString:@","]];
        [self.webView stringByEvaluatingJavaScriptFromString:javascriptDataString];
        [self.webView stringByEvaluatingJavaScriptFromString:@"var ctx = document.getElementById('myChart').getContext('2d');var myNewChart = new Chart(ctx);myNewChart.Line(data);"];
        self.label.text = @"Predicted job opportunities becoming available each year:";
        selectedButton = self.allButton;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}
    
- (void)getWorkingFuturesDataByQualifications {
    [[CPAPIClient sharedInstance] GET:@"wf/predict/breakdown/qualification" parameters:@{@"soc":[[NSUserDefaults standardUserDefaults] objectForKey:KEY_JOB][@"soc"]} success:^(AFHTTPRequestOperation *operation, id response){
        NSDictionary *responseDict = (NSDictionary *)response;
        NSArray *arrayOfData = responseDict[@"predictedEmployment"];
        years = [[NSMutableArray alloc] init];
        workingFuturesByQualification = [[NSMutableDictionary alloc] init];
        for (NSDictionary *yearOfData in arrayOfData) {
            [years addObject:yearOfData[@"year"]];
            for (NSDictionary *NQF in yearOfData[@"breakdown"]) {
                if (workingFuturesByQualification[NQF[@"name"]] == nil) {
                    workingFuturesByQualification[NQF[@"name"]] = [[NSMutableArray alloc] init];
                }
                [workingFuturesByQualification[NQF[@"name"]] addObject:NQF[@"employment"]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error: %@", error);
    }];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self getWorkingFuturesData];
}
    
- (void)filterTapped:(UIButton *)sender {
    if (!sender.selected) {
        NSString *javascriptDataString = [NSString stringWithFormat:@"var data = { labels :['%@'],                                                            datasets : [ { id : 'all', fillColor : 'rgba(220,220,220,0.5)', strokeColor : 'rgba(220,220,220,1)', pointColor : 'rgba(220,220,220,1)', pointStrokeColor : '#fff', data : [%@] } ] }", [years componentsJoinedByString:@"','"], [workingFuturesByQualification[sender.titleLabel.text] componentsJoinedByString:@","]];
        [self.webView stringByEvaluatingJavaScriptFromString:javascriptDataString];
        [self.webView stringByEvaluatingJavaScriptFromString:@"myNewChart.Line(data);"];
        self.label.text = [NSString stringWithFormat:@"Predicted job opportunities becoming available each year needing qualification %@:", [CPGraphViewController equivalentToNQF:sender.titleLabel.text]];
        [sender setSelected:!sender.selected];
        if (selectedButton != nil) {
            [selectedButton setSelected:!sender.selected];
        }
        selectedButton = sender;
    }
}
    
- (void)allFilterTapped:(UIButton *)sender {
    if (!sender.selected) {
        NSString *javascriptDataString = [NSString stringWithFormat:@"var data = { labels :['%@'],                                                            datasets : [ { id : 'all', fillColor : 'rgba(220,220,220,0.5)', strokeColor : 'rgba(220,220,220,1)', pointColor : 'rgba(220,220,220,1)', pointStrokeColor : '#fff', data : [%@] } ] }", [years componentsJoinedByString:@"','"], [workingFutures componentsJoinedByString:@","]];
        [self.webView stringByEvaluatingJavaScriptFromString:javascriptDataString];
        [self.webView stringByEvaluatingJavaScriptFromString:@"myNewChart.Line(data);"];
        self.label.text = @"Predicted job opportunities becoming available each year:";
        [sender setSelected:!sender.selected];
        if (selectedButton != nil) {
            [selectedButton setSelected:!sender.selected];
        }
        selectedButton = sender;
    }
}
    
+ (NSString *)equivalentToNQF:(NSString *)nqf {
    static NSDictionary *dict;
    if (dict == nil) {
        dict = @{@"NQF 1" : @"GCSE D-F", @"NQF 2" : @"GCSE A-C", @"NQF 3" : @"A levels", @"NQF 4" : @"Cert. of Higher Education", @"NQF 5" : @"Dip. of HE, Foundation Degrees", @"NQF 6" : @"Bachelor Degrees", @"NQF 7" : @"Master Degrees", @"NQF 8" : @"Doctorates"};
    }
    return dict[nqf];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
