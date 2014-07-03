#import <UIKit/UIKit.h>

using namespace cv;

@interface ELImageProcessing :UIImage

    + (Mat)cvMatFromUIImage:(UIImage *)image;

    + (UIImage *)UIImageFromCVMat:(Mat)cvMat;

@end