//
//  ELCvView.m
//  EasyLaunches
//
//  Created by Leonn Paiva on 6/13/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELImageProcessing.h"

using namespace cv;

@implementation ELImageProcessing
@synthesize knearest;

+ (Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

+(UIImage *)UIImageFromCVMat:(Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}


-(void) PreProcessImage:(Mat *) inImage outImage:(Mat *) outImage
{
    
}


-(void) LearnFromImages:(CvMat*) trainData trainClasses:(CvMat*) trainClasses
{
    
}

-(void) RunSelfTest:(KNearest&) knn2
{

}

-(void) AnalyseImage
{
    
    
    CvMat* sample2 = cvCreateMat(1, ImageSize, CV_32FC1);
    
    Mat image, gray, blur, thresh;
    
    vector < vector<cv::Point> > contours;
    image = imread("images/buchstaben.png", 1);
    
    cvtColor(image, gray, COLOR_BGR2GRAY);
    GaussianBlur(gray, blur, cv::Size(5, 5), 2, 2);
    adaptiveThreshold(blur, thresh, 255, 1, 1, 11, 2);
    findContours(thresh, contours, RETR_LIST, CHAIN_APPROX_SIMPLE);
    
    for (size_t i = 0; i < contours.size(); i++){
        vector < cv::Point > cnt = contours[i];
        int ca=contourArea(cnt);
        if (ca > 100)
        {
            cv::Rect rec = boundingRect(cnt);
            if (rec.height > 28)
            {
                Mat roi = image(rec);
                Mat stagedImage;
                //PreProcessImage(&roi, &stagedImage, sizex, sizey);
                for (int n = 0; n < ImageSize; n++){
                    sample2->data.fl[n] = stagedImage.data[n];
                }
                float result = knearest->find_nearest(sample2, 1);
                rectangle(image, cv::Point(rec.x, rec.y),
                          cv::Point(rec.x + rec.width, rec.y + rec.height),
                          Scalar(0, 0, 255), 2);  
                
                imshow("all", image);
                
                imshow("single", stagedImage);  
                
                
            }  
            
        }  
        
    }

}

@end
