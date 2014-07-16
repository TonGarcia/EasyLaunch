//
//  ELDefinitionOfColors.h
//  EasyLaunches
//
//  Created by Bryan Fernandes on 16/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELDefinitionOfColors : NSObject

@property (nonatomic) UIColor *elGreen;
@property (nonatomic) UIColor *elRed;
@property (nonatomic) UIColor *elBlue;

+ (id)sharedColor;

@end
