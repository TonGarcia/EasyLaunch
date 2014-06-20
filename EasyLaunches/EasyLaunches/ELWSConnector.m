//
//  ELWSConnector.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 20/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELWSConnector.h"

@implementation ELWSConnector
+ (NSString*) postTransaction:(NSString*)json
{
    NSString* method = @"http://";
    NSString* domain = @"192.168.0.6:3000";
    NSString* route = @"/api/transactions";
    NSString* url = [
                     NSString stringWithFormat:
                        @"%@%@%@",
                        method,
                        domain,
                        route
                    ];
    
    
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    // Set request type
    request.HTTPMethod = @"POST";
    
    // Set params to be sent to the server
    NSString *params = json;
    // Encoding type
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    // Add values and contenttype to the http header
    [request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[data length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:data];
    
    // Send the request
    [NSURLConnection connectionWithRequest:request delegate:self];
    return @"";
}
@end
