//
//  THPreviewView.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "THPreviewView.h"
#import "THContextManager.h"
#import "THFunctions.h"
@interface THPreviewView ()
@property (nonatomic) CGRect drawableBounds;
@end

@implementation THPreviewView
- (instancetype)initWithFrame:(CGRect)frame context:(EAGLContext *)context {
    self = [super initWithFrame:frame context:context];
    if (self) {
        self.enableSetNeedsDisplay = NO;
        self.backgroundColor = [UIColor blackColor];
        self.opaque = YES;
        
        // because the native video image from the back camera is in
        // UIDeviceOrientationLandscapeLeft (i.e. the home button is on the right),
        // we need to apply a clockwise 90 degree transform so that we can draw
        // the video preview as if we were in a landscape-oriented view;
        // if you're using the front camera and you want to have a mirrored
        // preview (so that the user is seeing themselves in the mirror), you
        // need to apply an additional horizontal flip (by concatenating
        // CGAffineTransformMakeScale(-1.0, 1.0) to the rotation transform)
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.frame = frame;
        
        [self bindDrawable];
        _drawableBounds = self.bounds;
        _drawableBounds.size.width = self.drawableWidth;
        _drawableBounds.size.height = self.drawableHeight;

    }
    return self;
}



- (void)setImage:(CIImage *)sourceImage {
    
    [self bindDrawable];
    
    [self.filter setValue:sourceImage forKey:kCIInputImageKey];
    CIImage *filteredImage = self.filter.outputImage;
    
    if (filteredImage) {
        
        CGRect cropRect =
        THCenterCropImageRect(sourceImage.extent, self.drawableBounds);
        
        [self.coreImageContext drawImage:filteredImage
                                  inRect:self.drawableBounds
                                fromRect:cropRect];
    }
    
    [self display];
    [self.filter setValue:nil forKey:kCIInputImageKey];
}



@end
