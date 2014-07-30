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
#define VALUE 0
#define VALUE_TYPE 1
#define INFO 2

@interface ELEditViewController ()

@end

@implementation ELEditViewController

@synthesize fieldValue;
@synthesize type;
@synthesize fieldInfo;

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
    fieldInfo.textColor = [[ELColorsDefinition sharedColor] elBlue];
    
    type.tintColor = [[ELColorsDefinition sharedColor] elGreen];
//    [[UISegmentedControl appearance] setTitleTextAttributes:@{
//                                                              NSForegroundColorAttributeName : [[ELColorsDefinition sharedColor] elRed]
//                                                              } forState:UIControlStateNormal];
//    
    self.navigationController.title = @"Editar";

}

// loading informations of the rows clicked or nothing if add new row
- (void)viewWillAppear:(BOOL)animated
{
    fieldValue.text = [[ELSingletonData sharedData] sharedProcessedValue];
    fieldInfo.text = [[ELSingletonData sharedData] sharedProcessedInfo];
    
    if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@RECEITA]) {
        type.selectedSegmentIndex = 0;
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elGreen];
        type.tintColor = [[ELColorsDefinition sharedColor] elGreen];
        
    } else if ([[[ELSingletonData sharedData] sharedMarkType] isEqualToString:@DESPESA]) {
        type.selectedSegmentIndex = 1;
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elRed];
        type.tintColor = [[ELColorsDefinition sharedColor] elRed];
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
    [[ELSingletonData sharedData] setSharedProcessedInfo:fieldInfo.text];
    
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
        type.tintColor = [[ELColorsDefinition sharedColor] elGreen];
        [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                                  NSForegroundColorAttributeName : [[ELColorsDefinition sharedColor] elRed]
                                                                  } forState:UIControlStateNormal];
    } else if (type.selectedSegmentIndex == 1) {
        fieldValue.textColor = [[ELColorsDefinition sharedColor] elRed];
        type.tintColor = [[ELColorsDefinition sharedColor] elRed];
        [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                                  NSForegroundColorAttributeName : [[ELColorsDefinition sharedColor] elGreen]
                                                                  } forState:UIControlStateNormal];
    }
}

// to hide keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
