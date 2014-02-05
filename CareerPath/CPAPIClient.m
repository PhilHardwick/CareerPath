//
//  CPAPIClient.m
//  CareerPath
//
//  Created by Philip Hardwick on 31/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPAPIClient.h"

@implementation CPAPIClient

+ (CPAPIClient *)sharedInstance {
    static dispatch_once_t once;
    static CPAPIClient *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.lmiforall.org.uk/api/v1/"]];
        sharedInstance.requestSerializer = [AFJSONRequestSerializer new];
        sharedInstance.responseSerializer = [AFJSONResponseSerializer new];
    });
    return sharedInstance;
}

@end
