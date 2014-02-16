//
//  CPNavController.m
//  CareerPath
//
//  Created by Philip Hardwick on 28/01/2014.
//  Copyright (c) 2014 Philip Hardwick. All rights reserved.
//

#import "CPNavController.h"
#import <Accelerate/Accelerate.h>

@interface CPNavController () {
    @private
    CGPoint startOffset;
    CGPoint destinationOffset;
    NSDate *startTime;
    NSTimer *timer;
    UIImageView *imageView;
    UIImageView *blurredImageView;
}

@end

@implementation CPNavController

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
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
	imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"night.jpg"]];
    blurredImageView = [[UIImageView alloc] initWithImage:[self applyBlurOnImage:[UIImage imageNamed:@"night.jpg"] withRadius:0.09f]];
    blurredImageView.alpha = 1.0f;
    [imageView setFrame:CGRectMake(0, 0, 1200, 800)];
    [blurredImageView setFrame:imageView.frame];
    //CGSize size = tempImageView.frame.size;
    [self.scrollView setContentSize:imageView.frame.size];
    [imageView setContentMode:UIViewContentModeTopLeft];
    [blurredImageView setContentMode:UIViewContentModeTopLeft];
    [self.scrollView addSubview:imageView];
    [self.scrollView addSubview:blurredImageView];
    [self.view insertSubview:self.scrollView atIndex:0];
}

- (void)segueOccuredWithDirection:(CPReplaceSegueMovementDirection)movementDirection {
    CGPoint currentPoint = self.scrollView.contentOffset;
    switch (movementDirection) {
        case CPReplaceSegueMovementDirectionDown:
            currentPoint.y -= 50;
            break;
        case CPReplaceSegueMovementDirectionUp:
            currentPoint.y += 50;
            break;
        case CPReplaceSegueMovementDirectionRight:
            currentPoint.x += 150;
            break;
        case CPReplaceSegueMovementDirectionLeft:
            currentPoint.x -= 150;
            break;
            
        default:
            break;
    }
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        [self.scrollView setContentOffset:currentPoint];
    } completion:nil];
//    float width, pixelsMoved;
//    CGRect imageFrame;
//    switch (movementDirection) {
//        case CPReplaceSegueMovementDirectionOutwards:
//        {
//            width = imageView.frame.size.width * 0.8f;
//            pixelsMoved = imageView.frame.size.width - width;
//            imageFrame = CGRectMake(pixelsMoved*0.5f, pixelsMoved*0.75f*0.5f, width, width*0.75f);
//            [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
//                [imageView setFrame:imageFrame];
//                [blurredImageView setFrame:imageFrame];
//            } completion:nil];
//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (void)segueOccuredWithDirection:(CPReplaceSegueMovementDirection)movementDirection andBlur:(bool)shouldBlur {
    [self segueOccuredWithDirection:movementDirection];
    if (shouldBlur) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            [blurredImageView setAlpha:1.0f];
        } completion:nil];
    } else {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            [blurredImageView setAlpha:0.0f];
        } completion:nil];
    }
}

- (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur withRadius:(CGFloat)blurRadius {
    if ((blurRadius < 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    int boxSize = (int)(blurRadius * 100);
    boxSize -= (boxSize % 2) + 1;
    CGImageRef rawImage = imageToBlur.CGImage;
    vImage_Buffer inBuffer;
    vImage_Buffer outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(rawImage);
    inBuffer.height = CGImageGetHeight(rawImage);
    inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(rawImage);
    outBuffer.height = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(imageToBlur.CGImage));
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    return returnImage;
}

-(void)segueOccuredBackToStart:(CPReplaceSegueMovementDirection)movementDirection {
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        [blurredImageView setAlpha:1.0f];
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
