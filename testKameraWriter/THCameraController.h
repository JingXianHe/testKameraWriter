//
//  THCameraController.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "THBaseCameraController.h"
#import "KameraDelegate.h"

@interface THCameraController : THBaseCameraController
- (void)startRecording;
- (void)stopRecording;
@property (nonatomic, getter = isRecording) BOOL recording;

@property (weak, nonatomic) id <THImageTarget> imageTarget;
@end
