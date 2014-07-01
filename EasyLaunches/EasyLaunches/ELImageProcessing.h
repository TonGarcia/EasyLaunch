#import <UIKit/UIKit.h>

using namespace cv;

const int train_samples = 1;
const int classes = 10;
const int sizex = 20;
const int sizey = 30;
const int ImageSize = sizex * sizey;

@interface ELImageProcessing :UIImage

    + (Mat)cvMatFromUIImage:(UIImage *)image;

    + (UIImage *)UIImageFromCVMat:(Mat)cvMat;

@end