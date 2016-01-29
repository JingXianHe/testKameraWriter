//
//  KameraDelegate.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//
@protocol THMovieWriterDelegate <NSObject>
- (void)didWriteMovieAtURL:(NSURL *)outputURL;
@end
#import <CoreMedia/CoreMedia.h>

@protocol THImageTarget <NSObject>

- (void)setImage:(CIImage *)image;

@end


@interface KameraDelegate : NSObject

@end
