//
//  ELSendToCloudViewController.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 21/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELSendToCloudViewController.h"
#import "ELAppDelegate.h"
#import "ELTransaction.h"

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


-(NSString*) toJSON:(NSMutableArray*)array
{
    NSString* begin = @"[";
    NSString* end = @"]";
    NSMutableString* returned = [[NSMutableString alloc] init];
    [returned appendString:begin];
    
    for (int i = 0; i < [array count]; i++)
    {
        [returned appendString:[array objectAtIndex:i]];
        if(i!=([array count]-1))[returned appendString:@","];
    }

    [returned appendString:end];
    return returned;
}

- (IBAction)sendToCloud:(id)sender
{
    // TransactionExemple
    NSString* val = @"58.50";
    NSString* date = @"22/08/1991-19:30";
    NSString* person = @"RESTAURANTE ITAITU";
    ELTransaction* tranExp = [[ELTransaction alloc] initWithValue:val AndDate:date AndInvolvedPerson:person];
    NSString* tranJSON = [tranExp toJSON];
    
    // Transaction added to the array
    [ELAppDelegate addTransactions:tranJSON];
    // Array converted into json & POST it
    NSString* array_in_json = [self toJSON:[ELAppDelegate transactions]];
    [ELWSConnector postTransaction:array_in_json];
}

- (IBAction)editValues:(id)sender
{
    NSLog(@"Edit those values man!");    
}
@end
