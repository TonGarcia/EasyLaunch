//
//  ELSendToCloudViewController.h
//  EasyLaunches
//
//  Created by Ilton  Garcia on 21/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELSendToCloudViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendToCloud;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editDatas;

- (IBAction)sendToCloud:(id)sender;
- (IBAction)editValues:(id)sender;
@end
