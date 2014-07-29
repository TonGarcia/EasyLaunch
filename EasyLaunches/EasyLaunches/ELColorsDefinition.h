//
//  ELDefinitionOfColors.h
//  EasyLaunches
//
//  Created by Bryan Fernandes on 16/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ELViewController.h"

@interface ELColorsDefinition : NSObject

@property (nonatomic) UIColor *elGreen;
@property (nonatomic) UIColor *elRed;
@property (nonatomic) UIColor *elBlue;
@property (nonatomic) UIColor *elGlobalTint;

+ (id)sharedColor;

@end
