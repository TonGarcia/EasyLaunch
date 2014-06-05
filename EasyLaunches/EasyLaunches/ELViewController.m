//
//  ELViewController.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 02/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELViewController.h"

@interface ELViewController ()

@end

@implementation ELViewController
{
    BOOL redEnabled;
    BOOL greenEnbaled;
    CALayer *layer;
}

@synthesize imageView;
@synthesize touched;
@synthesize location;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Validate if it has a camera
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    //enable gesture for imageview - listening touch
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickEventOnImage:)];
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //[tapGestureRecognizer setNumberOfTapsRequired:1];
//    [tapGestureRecognizer setDelegate:self];
    [imageView addGestureRecognizer:tapGestureRecognizer];
    imageView.userInteractionEnabled = YES;
    imageView.multipleTouchEnabled = YES;
}

- (IBAction)redMark:(id)sender
{
    redEnabled = YES;
    greenEnbaled = NO;
}

- (IBAction)greenMark:(id)sender
{
    greenEnbaled = YES;
    redEnabled = NO;
}

- (IBAction)clearMarks:(id)sender
{
    NSLog(@"cleaning..");
//    [[imageView layer] removeFromSuperlayer];
}

-(void)ClickEventOnImage:(id)sender
{
    // Validate if a color was selected
    if (!redEnabled && !greenEnbaled) {
        UIAlertView *alertColor = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"color not selected"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [alertColor show];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touched = [[event allTouches] anyObject];
    location = [touched locationInView:touched.view];
    NSLog(@"\nx=%.2f y=%.2f", location.x, location.y);
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touched = [[event allTouches] anyObject];
    location = [touched locationInView:touched.view];
    NSLog(@"\nx=%.2f y=%.2f", location.x, location.y);
    
    // Validate if a color was selected
    if (!redEnabled && !greenEnbaled) {
        UIAlertView *alertColor = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"color not selected"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [alertColor show];
    }
    
    // Painting image
    
    // defining layer
    layer = [CALayer layer];
    [layer setBounds:CGRectMake(0, 0, 20.0f, 20.0f)];
    [layer setCornerRadius:10.0f];
    [layer setMasksToBounds:YES];
    
    // selecting color to layer
    if (redEnabled) {
        [layer setBackgroundColor:[[UIColor redColor] CGColor]];
        //NSLog(@"Red Color Selected");
    } else if (greenEnbaled) {
        [layer setBackgroundColor:[[UIColor greenColor] CGColor]];
        //NSLog(@"Green Color Selected");
    }
    
    // position for to paint layer
    [layer setPosition:CGPointMake(location.x, location.y)];
    
    // defining opacity
    layer.opacity = 0.1f;
    [[imageView layer] opacity];
    
    // set layer in the image
    [[imageView layer] addSublayer:layer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Call the camera to take the photo
- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Select photo button listnning event
- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Load the image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Prepair the image
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    // Animate to callback from the camera
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // Listen the cancel event on the camera (permit it)
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
