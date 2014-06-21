//
//  ELSendToCloudViewController.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 21/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELSendToCloudViewController.h"

@interface ELSendToCloudViewController ()

@end

@implementation ELSendToCloudViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendToCloud:(id)sender
{
    [ELWSConnector postTransaction:@""];
}

- (IBAction)editValues:(id)sender
{
    NSLog(@"Edit those values man!");    
}

@end
