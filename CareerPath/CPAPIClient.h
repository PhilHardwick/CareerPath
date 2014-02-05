//
//  CPAPIClient.h
//  CareerPath
//
//  Created by Philip Hardwick on 31/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface CPAPIClient : AFHTTPRequestOperationManager

+(CPAPIClient *)sharedInstance;

@end
