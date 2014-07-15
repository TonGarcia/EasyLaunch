//
//  ELSingletonData.h
//  EasyLaunches
//
//  Created by Bryan Fernandes on 15/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELSingletonData : NSObject

@property (nonatomic) NSString *sharedProcessedValue;
@property (nonatomic) NSString *sharedMarkType;
@property (nonatomic) NSInteger refRow;
@property (nonatomic) BOOL saveClicked;
@property (nonatomic) BOOL editMode;

+ (id)sharedData;

@end
