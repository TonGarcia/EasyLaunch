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

UIButton *button;

@synthesize imageView;
@synthesize touched;
@synthesize location;
@synthesize markButton;
@synthesize markToolbar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Configurando Navigation Controller
    self.navigationItem.title = @"Easy Launch";
    
    // Left Button
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings-32.png"] style:UIBarButtonItemStyleDone target:self action:@selector(settingView)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // Right Button
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"upload_to_cloud_filled-32.png"] style:UIBarButtonItemStyleDone target:self action:@selector(sendImages)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
    // Validate if it has a camera
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
    
    // initialize crop area
    smallerPointX = imageView.frame.size.width;
    smallerPointY = imageView.frame.size.height;
    biggerPointX = 0.0;
    biggerPointY = 0.0;
    
    //set values
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 20.0;
    opacity = 0.1;
    
}

- (IBAction)markButtonClicked:(UIBarButtonItem *)sender forEvent:(UIEvent*)event
{
    [self becomeFirstResponder];
    
    UIView *buttonView=[[event.allTouches anyObject] view];
    CGRect buttonFrame=[buttonView convertRect:buttonView.frame toView:self.view];
    
    UIMenuItem *menuItemRedColor = [[UIMenuItem alloc] initWithTitle:@"Red" action:@selector(redMark:)];
    UIMenuItem *menuItemGreenColor = [[UIMenuItem alloc] initWithTitle:@"Green" action:@selector(greenMark:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    [menu setMenuItems:[NSArray arrayWithObjects:menuItemRedColor, menuItemGreenColor, nil]];
    
    [menu setTargetRect:buttonFrame inView:self.view];
    
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    BOOL result = NO;
    if(@selector(greenMark:) == action ||
       @selector(redMark:) == action) {
        result = YES;
    }
    return result;
}

- (void)redMark:(id)sender
{
    redEnabled = YES;
    greenEnbaled = NO;
    red = 255.0/255.0;
    green = 0.0/255.0;
    markButton.tintColor = [UIColor redColor];
}

- (void)greenMark:(id)sender
{
    greenEnbaled = YES;
    redEnabled = NO;
    red=88/255.0;
    green=181/255.0;
    blue=73/255.0;
    markButton.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


- (IBAction)clearMarks:(id)sender
{
    [self setImageAndResizeUIImageView];
    
    smallerPointX = imageView.frame.size.width;
    smallerPointY = imageView.frame.size.height;
    biggerPointX = 0.0;
    biggerPointY = 0.0;
}

-(void)setImageAndResizeUIImageView
{
    NSLog(@"Setting image and resizing UIImageView...");
    imageView.image = myImage;
    imageView.frame = CGRectMake(0, 0, myImage.size.width/2, myImage.size.height/2);
    imageView.center = imageView.superview.center;
}

- (void)settingView
{
    NSLog(@"Create view for settings");
}

- (void)sendImages
{
    NSLog(@"Create view and action to send images");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
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
    
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:imageView];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
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
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [imageView setAlpha:1.0];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
    
    touched = [[event allTouches] anyObject];
    location = [touched locationInView:imageView];
    NSLog(@"\nx=%.2f y=%.2f", location.x, location.y);
    
    if (smallerPointX > location.x) {
        smallerPointX = location.x;
    }
    
    if (smallerPointY > location.y) {
        smallerPointY = location.y;
    }
    
    if (biggerPointX < location.x) {
        biggerPointX = location.x;
    }
    
    if (biggerPointY < location.y) {
        biggerPointY = location.y;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    biggerPointX *= 2;
    biggerPointY *= 2;
    smallerPointX *= 2;
    smallerPointY *= 2;
    brush *= 2;
    
    CGRect cropRect = CGRectMake(smallerPointX-(brush/2), smallerPointY-(brush/2), (biggerPointX - smallerPointX)+brush, (biggerPointY - smallerPointY)+brush);
    CGImageRef croppedImage = CGImageCreateWithImageInRect([myImage CGImage], cropRect);
    
    brush /= 2;
    // Leonn, abaixo está um código que irá setar a imagem recortada. No entanto, não devemos setar e sim salvar em alguma estrutura.
    // o tempo acabou aqui e preciso ir embora, caso contrário o Braga me esgana, senão eu faria e terminaria. O corte está perfeito, não mude nada kkkk.
    //O que falta é salvar as imagens. Procure uma estrutura que salve os recortes e pronto. Observe que o tipo UIImage não pega o tipo CGImageRef,
    // veja abaixo como eu fiz pra unir os diferentes tipos.
    
    imageView.image = [UIImage imageWithCGImage:croppedImage];
    
    //smallerPointX = imageView.frame.size.width;
    //smallerPointY = imageView.frame.size.height;
    //biggerPointX = 0.0;
    //biggerPointY = 0.0;
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
    [imageView clearsContextBeforeDrawing];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)ds:(id)sender {
}

- (IBAction)markButtonClicked:(id)sender {
}

// Load the image
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Prepair the image
    myImage = info[UIImagePickerControllerEditedImage];
    
    [self setImageAndResizeUIImageView];
    
    // Animate to callback from the camera
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // Listen the cancel event on the camera (permit it)
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
