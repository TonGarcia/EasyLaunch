//
//  ELViewController.h
//  EasyLaunches
//
//  Created by Ilton  Garcia on 02/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/highgui.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/ml/ml.hpp>

#import "IASKAppSettingsViewController.h"

using namespace cv;

@interface ELViewController : UIViewController <UIImagePickerControllerDelegate,
                                                UINavigationControllerDelegate,
                                                UIGestureRecognizerDelegate>
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    UIImage *myImage;
    UIImage *noPhoto;
    BOOL redEnabled;
    BOOL greenEnbaled;
    CALayer *layer;
    CGFloat smallerPointX;
    CGFloat biggerPointX;
    CGFloat smallerPointY;
    CGFloat biggerPointY;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UITouch *touched;
@property (nonatomic) CGPoint location;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *markButton;
@property (strong, nonatomic) IBOutlet UIToolbar *markToolbar;

- (void)redMark:(id)sender;
- (void)greenMark:(id)sender;

- (IBAction)clearMarks:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)markButtonClicked:(UIBarButtonItem *)sender forEvent:(UIEvent*)event;

@end
