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
    NSDictionary *thisTransaction = [
                                        NSDictionary dictionaryWithObjectsAndKeys:
                                        @"value", _value,
                                        @"date", _date,
                                        @"involved_person", _involvedPerson,
                                        nil
                                     ];
    return [thisTransaction JSONRepresentation];
}
@end
