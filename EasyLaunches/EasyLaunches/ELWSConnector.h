//
//  ELWSConnector.h
//  EasyLaunches
//
//  Created by Ilton  Garcia on 20/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELWSConnector : NSObject
    + (NSString*) postTransaction:(NSString*)json;
@end
