//
//  ELViewController.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 02/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELViewController.h"
#import "ELImageProcessing.h"
#import "tesseract.h"

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
    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Ok" style:UIBarButtonItemStyleDone target:self action:@selector(backHomeView:)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    //Configurando Navigation Controller
    
    // Left Button
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"settings-32.png"] style:UIBarButtonItemStyleDone target:self action:@selector(callSettingView)];
//    
//    self.navigationItem.leftBarButtonItem = leftButton;
//    
    // Right Button
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"upload_to_cloud_filled-32.png"] style:UIBarButtonItemStyleDone target:self action:@selector(sendImages)];
//    self.navigationItem.rightBarButtonItem = rightButton;
    
    noPhoto = [UIImage imageNamed:@"no-photo.jpeg"];
    myImage = noPhoto;
    [self setImageAndResizeUIImageView];
    
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
    
    UIMenuItem *menuItemRedColor = [[UIMenuItem alloc] initWithTitle:@"Despesa" action:@selector(redMark:)];
    UIMenuItem *menuItemGreenColor = [[UIMenuItem alloc] initWithTitle:@"Receita" action:@selector(greenMark:)];

    UIMenuItem *menuItemBlueColor = [[UIMenuItem alloc] initWithTitle:@"Info" action:@selector(blueMark:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    [menu setMenuItems:[NSArray arrayWithObjects:menuItemRedColor, menuItemGreenColor, menuItemBlueColor, nil]];
    
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
       @selector(redMark:) == action ||
       @selector(blueMark:) == action) {
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
    blue = 0.0/2555.0;
    markButton.tintColor = [UIColor redColor];
}

- (void)greenMark:(id)sender
{
    greenEnbaled = YES;
    redEnabled = NO;
    red=0/255.0;
    green=168/255.0;
    blue=89/255.0;
    markButton.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (void)blueMark:(id)sender
{
    greenEnbaled = YES;
    redEnabled = NO;
    red=0/255.0;
    green=0/255.0;
    blue=255/255.0;
    markButton.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


- (IBAction)clearMarks:(id)sender
{
    [self setImageAndResizeUIImageView];
    
    smallerPointX = myImage.size.width;
    smallerPointY = myImage.size.height;
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

- (void)callSettingView
{
    NSLog(@"Create view for settings");
    //self.navigationController.rotatingFooterView = self.childViewControllers;
}

- (void)sendImages
{
    NSLog(@"Create view and action to send images");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // validate if a photo not selected
    if(imageView.image == noPhoto) {
        UIAlertView *alertColor = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                             message:@"Nenhuma foto foi selecionada"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        [alertColor show];
    }
    
    // Validate if a color was selected
    else if (!redEnabled && !greenEnbaled) {
        UIAlertView *alertColor = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                             message:@"Cor não selecionada"
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
        UIAlertView *alertColor = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                             message:@"cor não selecionada"
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
    
    //imageView.image = myImage;
    
    
    //Processamento da imagem
    Mat img= [ELImageProcessing cvMatFromUIImage:[UIImage imageWithCGImage:croppedImage]];
    cvtColor(img, img, COLOR_BGR2GRAY);
    GaussianBlur(img, img, cv::Size(5, 5), 2, 2);
    adaptiveThreshold(img, img, 255, 1, 1, 11, 2);
    
    //vector < vector<cv::Point> > contours;
    //findContours(img, contours, RETR_LIST, CHAIN_APPROX_SIMPLE);
    
    
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"por+eng"];
    //[tesseract setVariableValue:@"0123456789" forKey:@"tessedit_char_whitelist"];
    [tesseract setImage:[ELImageProcessing UIImageFromCVMat:img]];
    [tesseract recognize];
    
    //Valor processado = [tesseract recognizedText]
    NSLog(@"%@", [tesseract recognizedText]);
    
    NSString *message = [NSString stringWithFormat: @"Valor processado: %@",[tesseract recognizedText]];
    
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    int duration = 1; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
    
    [tesseract clear];
    
    
    
   // UIImage *img2= [ELCvView UIImageFromCVMat:img];
   // imageView.image = img2;
    
    smallerPointX = imageView.frame.size.width;
    smallerPointY = imageView.frame.size.height;
    biggerPointX = 0.0;
    biggerPointY = 0.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Call the camera to take the photo
- (IBAction)takePhoto:(id)sender {
    
    // Validate if it has a camera
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                              message:@"câmera não encontrada"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
        return;
    }
    
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
