//
//  ELTransaction.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 20/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELTransaction.h"

@implementation ELTransaction
- (id)initWithValue:(NSString *)value AndDate:(NSString *)date AndInvolvedPerson:(NSString *) involvedPerson
{
    self = [super init];
    
    if(self)
    {
        _value = value;
        _date = date;
        _involvedPerson = involvedPerson;
    }
    
    return self;
}

- (NSString*) toJSON
{
    NSString *json = [
                        NSString stringWithFormat:
                        @"{value:%@, date:%@, involved_person:%@}",
                        _value,
                        _date,
                        _involvedPerson
                      ];
    
    return json;
}
@end
