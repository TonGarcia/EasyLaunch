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

#define RECEITA "Receita"
#define DESPESA "Despesa"
#define INFO "Info"

@interface ELSendToCloudViewController ()

@end

@implementation ELSendToCloudViewController
{
    NSArray *paths;
    NSString *documentsDirectory;
    NSString *path;
}

@synthesize tableViewWithData;
@synthesize sendToCloud;
@synthesize editData;
@synthesize allData;
@synthesize allColors;

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
    
    allData = [[NSMutableArray alloc]init];
    
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/EasyLaunches.plist"]];
    
    NSArray *load = [NSArray arrayWithContentsOfFile:path];
    for (NSMutableArray *item in load) {
        [allData addObject:item];
    }
    
    // don't work
    //self.navigationItem.backBarButtonItem = @"Cancelar";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// elements count
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allData count];
}


// set elements in the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[allData objectAtIndex:indexPath.row] objectAtIndex:0];
    
    // code for test
    if ([[[allData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@RECEITA]) {
        cell.textLabel.textColor = [UIColor greenColor];
        
    } else if ([[[allData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@DESPESA]) {
        cell.textLabel.textColor = [UIColor redColor];
    } else if ([[[allData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@INFO]) {
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [allData removeObjectAtIndex:indexPath.row];
        [tableViewWithData deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // here code for add in array and row in the table view
    }
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

- (IBAction)editValues:(id)sender
{
    if ([tableViewWithData isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        
        [tableViewWithData setEditing:NO animated:YES];
        [self.editData setTitle:@"Editar"];
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.leftItemsSupplementBackButton = YES;
        
        [allData writeToFile:path atomically:YES];
        
        [self.sendToCloud setEnabled:YES];
    }
    else {
        [self.editData setTitle:@"Concluído"];
        
        [self.sendToCloud setEnabled:NO];
        self.navigationItem.leftItemsSupplementBackButton = NO;
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewValue)];
        self.navigationItem.leftBarButtonItem = leftButton;
        
        // Turn on edit mode
        
        [tableViewWithData setEditing:YES animated:YES];
    }
}

- (void)addNewValue
{
    NSMutableArray *new = [[NSMutableArray alloc]init];
    [new addObject:@"New data added"];
    [new addObject:@RECEITA];
    [allData addObject:new];
    [tableViewWithData reloadData];
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

@end
