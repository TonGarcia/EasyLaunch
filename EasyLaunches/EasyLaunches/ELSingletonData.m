//
//  ELSingletonData.m
//  EasyLaunches
//
//  Created by Bryan Fernandes on 15/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELSingletonData.h"

@implementation ELSingletonData

@synthesize sharedProcessedValue;
@synthesize sharedMarkType;
@synthesize sharedProcessedInfo;
@synthesize refRow;
@synthesize saveClicked;
@synthesize editMode;

- (id)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [ELSingletonData sharedData]" userInfo:nil];
    
    return nil;
}

+ (id) sharedData
{
    static ELSingletonData *sharedData = nil;
    
    if (!sharedData) {
        sharedData = [[self alloc] initPrivate];
    }
    
    return sharedData;
}

- (id)initPrivate
{
    self = [super init];
    
    if (self) {
        sharedProcessedValue = [[NSString alloc]init];
        sharedMarkType = [[NSString alloc]init];
        sharedProcessedInfo = [[NSString alloc] init];
    }
    
    return self;
}

@end
