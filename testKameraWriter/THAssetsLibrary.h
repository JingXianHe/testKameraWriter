//
//  THAssetsLibrary.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//


typedef void(^THAssetsLibraryWriteCompletionHandler)(BOOL success, NSError *error);
@interface THAssetsLibrary : NSObject
- (void)writeImage:(UIImage *)image completionHandler:(THAssetsLibraryWriteCompletionHandler)completionHandler;
- (void)writeVideoAtURL:(NSURL *)videoURL completionHandler:(THAssetsLibraryWriteCompletionHandler)completionHandler;
@end
