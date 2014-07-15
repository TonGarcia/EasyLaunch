//
//  ELEditViewController.m
//  EasyLaunches
//
//  Created by Bryan Fernandes on 14/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELEditViewController.h"
#import "ELSingletonData.h"

#define RECEITA "Receita"
#define DESPESA "Despesa"
#define INFO "Info"

@interface ELEditViewController ()

@end

@implementation ELEditViewController

@synthesize fieldValue;
@synthesize type;

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
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveValueEdited)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    fieldValue.text = [[ELSingletonData sharedData] sharedProcessedValue];
    
    if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@RECEITA]) {
        type.selectedSegmentIndex = 0;
    } else if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@DESPESA]) {
        type.selectedSegmentIndex = 1;
    } else if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@INFO]) {
        type.selectedSegmentIndex = 2;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveValueEdited
{
    [[ELSingletonData sharedData] setSharedProcessedValue:fieldValue.text];
    
    if (type.selectedSegmentIndex == 0) {
        [[ELSingletonData sharedData] setSharedMarkType:@RECEITA];
    } else if (type.selectedSegmentIndex == 1) {
        [[ELSingletonData sharedData] setSharedMarkType:@DESPESA];
    } else if (type.selectedSegmentIndex == 2) {
        [[ELSingletonData sharedData] setSharedMarkType:@INFO];
    }
    
    [[ELSingletonData sharedData] setSaveClicked:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
