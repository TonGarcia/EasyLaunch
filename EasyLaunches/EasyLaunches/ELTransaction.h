//
//  ELTransaction.h
//  EasyLaunches
//
//  Created by Ilton  Garcia on 20/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELTransaction : NSObject
    @property NSString *value;
    @property NSString *date;
    @property NSString *involvedPerson;

    - (id)initWithValue:(NSString *)value AndDate:(NSString *)date AndInvolvedPerson:(NSString *) involvedPerson;

    + (NSString*) toJSON;
@end
