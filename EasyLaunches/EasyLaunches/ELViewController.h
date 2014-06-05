//
//  ELViewController.h
//  EasyLaunches
//
//  Created by Ilton  Garcia on 02/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UITouch *touched;
@property (nonatomic) CGPoint location;

- (IBAction)redMark:(id)sender;
- (IBAction)greenMark:(id)sender;
- (IBAction)clearMarks:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;

- (void)ClickEventOnImage:(id)sender;

@end
