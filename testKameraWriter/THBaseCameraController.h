//
//  THBaseCameraController.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "THCameraControllerDelegate.h"
FOUNDATION_EXPORT NSString *const THMovieCreatedNotification;
@interface THBaseCameraController : NSObject
@property (weak, nonatomic) id <THCameraControllerDelegate> delegate;
@property (strong, nonatomic, readonly) AVCaptureSession *captureSession;
@property (strong, nonatomic, readonly) dispatch_queue_t dispatchQueue;

// Session Configuration
- (BOOL)setupSession:(NSError **)error;
- (BOOL)setupSessionInputs:(NSError **)error;
- (BOOL)setupSessionOutputs:(NSError **)error;
- (NSString *)sessionPreset;

- (void)startSession;
- (void)stopSession;
@end
