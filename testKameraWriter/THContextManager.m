//
//  THContextManager.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "THContextManager.h"

@implementation THContextManager
+ (instancetype)sharedInstance {
    static dispatch_once_t predicate;
    static THContextManager *instance = nil;
    dispatch_once(&predicate, ^{instance = [[self alloc] init];});
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        NSDictionary *options = @{kCIContextWorkingColorSpace : [NSNull null]};
        //Creates a Core Image context from an EAGL context using the specified options.
        //You should use this method if you want to get real-time performance on a device. One of the advantages of using an EAGL context is that the rendered image stays on the GPU and does not get copied to CPU memory.
        _ciContext = [CIContext contextWithEAGLContext:_eaglContext options:options];
    }
    return self;
}

@end
