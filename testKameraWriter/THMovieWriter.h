//
//  THMovieWriter.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "KameraDelegate.h"

@interface THMovieWriter : NSObject
- (id)initWithVideoSettings:(NSDictionary *)videoSettings  audioSettings:(NSDictionary *)audioSettings dispatchQueue:(dispatch_queue_t)dispatchQueue;
- (void)startWriting;
- (void)stopWriting;
@property (nonatomic) BOOL isWriting;

@property (weak, nonatomic) id<THMovieWriterDelegate> delegate;             // 2

- (void)processSampleBuffer:(CMSampleBufferRef)sampleBuffer;                // 3
@end
