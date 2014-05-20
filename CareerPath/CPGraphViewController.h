//
//  CPGraphViewController.h
//  CareerPath
//
//  Created by Philip Hardwick on 07/02/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPBaseViewController.h"

@interface CPGraphViewController : CPBaseViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *allButton;
    
-(IBAction)filterTapped:(UIButton *)sender;
-(IBAction)allFilterTapped:(UIButton *)sender;

@end
