//
//  THCameraController.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "THCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import "THMovieWriter.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface THCameraController () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate, THMovieWriterDelegate>

@property (strong, nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (strong, nonatomic) AVCaptureAudioDataOutput *audioDataOutput;

@property (strong, nonatomic) THMovieWriter *movieWriter;

@end
@implementation THCameraController
- (BOOL)setupSessionOutputs:(NSError **)error {
    
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];         // 1
    
    NSDictionary *outputSettings =
    @{(id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)};
    
    self.videoDataOutput.videoSettings = outputSettings;
    self.videoDataOutput.alwaysDiscardsLateVideoFrames = NO;                // 2
    
    [self.videoDataOutput setSampleBufferDelegate:self queue:self.dispatchQueue];
    
    if ([self.captureSession canAddOutput:self.videoDataOutput]) {
        [self.captureSession addOutput:self.videoDataOutput];
    } else {
        return NO;
    }
    
    self.audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];         // 3
    
    [self.audioDataOutput setSampleBufferDelegate:self
                                            queue:self.dispatchQueue];
    
    if ([self.captureSession canAddOutput:self.audioDataOutput]) {
        [self.captureSession addOutput:self.audioDataOutput];
    } else {
        return NO;
    }
    
    NSString *fileType = AVFileTypeQuickTimeMovie;
    
    NSDictionary *videoSettings =
    [self.videoDataOutput
     recommendedVideoSettingsForAssetWriterWithOutputFileType:fileType];
    
    NSDictionary *audioSettings = [self.audioDataOutput recommendedAudioSettingsForAssetWriterWithOutputFileType:fileType];
    
    self.movieWriter =
    [[THMovieWriter alloc] initWithVideoSettings:videoSettings
                                   audioSettings:audioSettings
                                   dispatchQueue:self.dispatchQueue];
    self.movieWriter.delegate = self;
    
    return YES;
}

- (NSString *)sessionPreset {
    return AVCaptureSessionPreset1280x720;
}

- (void)startRecording {
    [self.movieWriter startWriting];
    self.recording = YES;
}

- (void)stopRecording {
    [self.movieWriter stopWriting];
    self.recording = NO;
}


#pragma mark - Delegate methods

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    [self.movieWriter processSampleBuffer:sampleBuffer];
    
    if (captureOutput == self.videoDataOutput) {
        //用滤镜加工视频帧
        CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
        
        CIImage *sourceImage = [CIImage imageWithCVPixelBuffer:imageBuffer options:nil];
        
        [self.imageTarget setImage:sourceImage];
    }
}
//这个方法是传入给THMovieWriter让其在真正结束多媒体写入的时候触发，outputURL由THMovieWriter传入其实就是一直用来储存视频和音频组合的临时文件，这里可以更改outputURL也可以直接使用，都是将临时文件转为永久文件
- (void)didWriteMovieAtURL:(NSURL *)outputURL {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
        
        ALAssetsLibraryWriteVideoCompletionBlock completionBlock;
        
        completionBlock = ^(NSURL *assetURL, NSError *error){
            if (error) {
                [self.delegate assetLibraryWriteFailedWithError:error];
            }
        };
        [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:completionBlock];
    }
}

@end
