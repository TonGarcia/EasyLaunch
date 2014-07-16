//
//  ELDefinitionOfColors.m
//  EasyLaunches
//
//  Created by Bryan Fernandes on 16/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELDefinitionOfColors.h"

@implementation ELDefinitionOfColors

@synthesize elGreen;
@synthesize elRed;
@synthesize elBlue;

- (id)init
{
    @throw [NSException exceptionWithName:@"Colors" reason:@"Use + [ELDefinitionOfColors sharedColor]" userInfo:nil];
    
    return nil;
}

+ (id) sharedColor
{
    static ELDefinitionOfColors *sharedColor = nil;
    
    if (!sharedColor) {
        sharedColor = [[self alloc] initPrivate];
    }
    
    return sharedColor;
}

- (id)initPrivate
{
    self = [super init];
    
    if (self) {
        elGreen = [[UIColor alloc]init];
        elGreen = [UIColor colorWithRed:0.0/255.0 green:168.0/255.0 blue:89.0/255.0 alpha:1];
        
        elRed = [[UIColor alloc] init];
        elRed = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/2555.0 alpha:1];
        
        elBlue = [[UIColor alloc] init];
        elBlue = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1];
    }
    
    return self;
}

// subscribe methods (sets) to not update colors
- (void)setElRed:(UIColor *)elRed
{
    @throw [NSException exceptionWithName:@"Colors" reason:@"Colors can not be changed" userInfo:nil];
    return;
}

- (void)setElBlue:(UIColor *)elBlue
{
    @throw [NSException exceptionWithName:@"Colors" reason:@"Colors can not be changed" userInfo:nil];
    return;
}

- (void)setElGreen:(UIColor *)elGreen
{
    @throw [NSException exceptionWithName:@"Colors" reason:@"Colors can not be changed" userInfo:nil];
    return;
}

@end
