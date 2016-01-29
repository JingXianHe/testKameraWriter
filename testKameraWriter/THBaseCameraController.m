//
//  THBaseCameraController.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "THBaseCameraController.h"
#import "NSFileManager+THAdditions.h"
#import "THAssetsLibrary.h"
NSString *const THThumbnailCreatedNotification = @"THThumbnailCreated";
NSString *const THMovieCreatedNotification = @"THMovieCreated";
@interface THBaseCameraController ()

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (weak, nonatomic) AVCaptureDeviceInput *activeVideoInput;

@property (strong, nonatomic) NSURL *outputURL;
@property (strong, nonatomic) THAssetsLibrary *library;

@end

@implementation THBaseCameraController
- (instancetype)init {
    self = [super init];
    if (self) {
        _library = [[THAssetsLibrary alloc] init];
        _dispatchQueue = dispatch_queue_create("com.tapharmonic.CaptureDispatchQueue", NULL);
    }
    return self;
}

- (BOOL)setupSession:(NSError **)error {
    
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = [self sessionPreset];
    
    if (![self setupSessionInputs:error]) {
        return NO;
    }
    
    if (![self setupSessionOutputs:error]) {
        return NO;
    }
    
    return YES;
}

- (NSString *)sessionPreset {
    return AVCaptureSessionPresetHigh;
}

- (BOOL)setupSessionInputs:(NSError **)error {
    
    // Set up default camera device
    AVCaptureDevice *videoDevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:error];
    if (videoInput) {
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Failed to add video input."};

            return NO;
        }
    } else {
        return NO;
    }
    
    // Setup default microphone
    AVCaptureDevice *audioDevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    AVCaptureDeviceInput *audioInput =
    [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:error];
    if (audioInput) {
        if ([self.captureSession canAddInput:audioInput]) {
            [self.captureSession addInput:audioInput];
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"Failed to add audio input."};

            return NO;
        }
    } else {
        return NO;
    }
    
    return YES;
}

- (BOOL)setupSessionOutputs:(NSError **)error {
    return NO;
}

- (void)startSession {
    dispatch_async(self.dispatchQueue, ^{
        if (![self.captureSession isRunning]) {
            [self.captureSession startRunning];
        }
    });
}

- (void)stopSession {
    dispatch_async(self.dispatchQueue, ^{
        if ([self.captureSession isRunning]) {
            [self.captureSession stopRunning];
        }
    });
    
}

@end
