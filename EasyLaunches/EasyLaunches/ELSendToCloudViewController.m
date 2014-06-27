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
{
    BOOL check;
}

@synthesize tableViewWithData;
@synthesize sendToCloud;
@synthesize editData;
@synthesize dataMutableArray;

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
    dataMutableArray = [[NSMutableArray alloc] init];
    [dataMutableArray addObject:@"Egg Benedict"];
    [dataMutableArray addObject:@"Mushroom Risotto"];
    [dataMutableArray addObject:@"Full Breakfast"];
    [dataMutableArray addObject:@"Hamburger"];
    [dataMutableArray addObject:@"Ham and Egg Sandwich"];
    [dataMutableArray addObject:@"Creme Brelee"];
    [dataMutableArray addObject:@"White Chocolate Donut"];
    [dataMutableArray addObject:@"Starbucks Coffee"];
    [dataMutableArray addObject:@"Vegetable Curry"];
    [dataMutableArray addObject:@"Instant Noodle with Egg"];
    [dataMutableArray addObject:@"Noodle with BBQ Pork"];
    [dataMutableArray addObject:@"Japanese Noodle with Pork"];
    [dataMutableArray addObject:@"Green Tea"];
    [dataMutableArray addObject:@"Thai Shrimp Cake"];
    [dataMutableArray addObject:@"Angry Birds Cake"];
    [dataMutableArray addObject:@"Ham and Cheese Panini"];
    
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
    return [dataMutableArray count];
}


// set elements in the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [dataMutableArray objectAtIndex:indexPath.row];
    
    // code for test
    if (check) {
        cell.textLabel.textColor = [UIColor greenColor];
        check = NO;
    } else {
        cell.textLabel.textColor = [UIColor redColor];
        check = YES;
    }
    
    return cell;
}

//______________________________________________________start______________________________________________________________________________

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [dataMutableArray removeObjectAtIndex:indexPath.row];
        [tableViewWithData deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // here code for add in array and row in the table view
    }
}

//_______________________________________________________end_______________________________________________________________________________

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
    [dataMutableArray addObject:@"New data added"];
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
