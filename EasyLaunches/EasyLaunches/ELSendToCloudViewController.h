//
//  ELSendToCloudViewController.h
//  EasyLaunches
//
//  Created by Ilton  Garcia on 21/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELWSConnector.h"

@interface ELSendToCloudViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendToCloud;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editData;
@property (strong, nonatomic) IBOutlet UITableView *tableViewWithData;
@property (nonatomic) NSMutableArray *dataMutableArray;

- (IBAction)sendToCloud:(id)sender;
- (IBAction)editValues:(id)sender;
@end
