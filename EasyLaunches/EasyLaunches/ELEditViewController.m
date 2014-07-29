//
//  ELEditViewController.m
//  EasyLaunches
//
//  Created by Bryan Fernandes on 14/07/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELEditViewController.h"
#import "ELSingletonData.h"
#import "ELColorsDefinition.h"

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
    fieldValue.textColor = [[ELColorsDefinition sharedColor] elGreen];
}

// loading informations of the rows clicked or nothing if add new row
- (void)viewWillAppear:(BOOL)animated
{
    fieldValue.text = [[ELSingletonData sharedData] sharedProcessedValue];
    
    if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@RECEITA]) {
        type.selectedSegmentIndex = 0;
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elGreen];
    } else if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@DESPESA]) {
        type.selectedSegmentIndex = 1;
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elRed];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// when save button is clicked
- (void)saveValueEdited
{
    [[ELSingletonData sharedData] setSharedProcessedValue:fieldValue.text];
    
    if (type.selectedSegmentIndex == 0) {
        [[ELSingletonData sharedData] setSharedMarkType:@RECEITA];
    } else if (type.selectedSegmentIndex == 1) {
        [[ELSingletonData sharedData] setSharedMarkType:@DESPESA];
    }
    
    [[ELSingletonData sharedData] setSaveClicked:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    

}

// to set color for textfield (fieldValue)
- (IBAction)segmentSetColor:(id)sender
{
    if (type.selectedSegmentIndex == 0) {
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elGreen];
    } else if (type.selectedSegmentIndex == 1) {
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elRed];
    }
}

// to hide keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
