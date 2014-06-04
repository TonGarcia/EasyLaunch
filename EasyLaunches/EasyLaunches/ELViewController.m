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

BOOL redEnabled;
BOOL greenEnbaled;

@implementation ELViewController
@synthesize imageView;
@synthesize bezierPath;

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
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [tapGestureRecognizer setDelegate:self];
    [imageView addGestureRecognizer:tapGestureRecognizer];
    imageView.userInteractionEnabled = YES;
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

-(void)ClickEventOnImage:(id)sender
{
    if (!redEnabled && !greenEnbaled) {
        UIAlertView *alertColor = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"color not selected"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [alertColor show];
    }
    
    if (redEnabled) {
        NSLog(@"Red Color Selected");
    } else if (greenEnbaled) {
        NSLog(@"Green Color Selected");
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touched = [[event allTouches] anyObject];
    CGPoint location = [touched locationInView:touched.view];
   //NSLog(@"\nx=%.2f y=%.2f", location.x, location.y);
    
    CALayer *layer = [CALayer layer];
    [layer setBounds:CGRectMake(0, 0, 20.0f, 20.0f)];
    [layer setCornerRadius:10.0f];
    [layer setMasksToBounds:YES];
    
    if (redEnabled) {
        [layer setBackgroundColor:[[UIColor redColor] CGColor]];
    } else if (greenEnbaled) {
        [layer setBackgroundColor:[[UIColor greenColor] CGColor]];
    }
    
    [layer setPosition:CGPointMake(location.x, location.y)];
    
    [[imageView layer] addSublayer:layer];
    
        
    
    
//    UIGraphicsBeginImageContext(imageView.image.size);
//    [imageView.image drawAtPoint:CGPointMake(location.x, location.y)];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 5.0);
//    CGContextMoveToPoint(context, location.x, location.y);
//    CGContextAddLineToPoint(context, imageView.image.size.width, location.y);
//    
//    if (redEnabled) {
//        CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
//    } else if (greenEnbaled) {
//        CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
//    }
//    
//    CGContextStrokePath(context);
//    
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    imageView.image = newImage;
//    UIGraphicsEndImageContext();
    
}


//-(void)tappedImage:(UIGestureRecognizer *)gestureRecognizer
//{
//    NSLog(@"it works imageView touch");
//}

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
