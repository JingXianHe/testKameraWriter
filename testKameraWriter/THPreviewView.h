//
//  THPreviewView.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "KameraDelegate.h"

@interface THPreviewView : GLKView <THImageTarget>
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIContext *coreImageContext;
@end
