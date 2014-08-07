//
//  ELEditViewController.h
//  EasyLaunches
//
//  Created by Bryan Fernandes on 14/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELEditViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *fieldValue;
@property (strong, nonatomic) IBOutlet UISegmentedControl *type;
@property (weak, nonatomic) IBOutlet UITextField *fieldInfo;

- (IBAction)segmentSetColor:(id)sender;

@end
