//
//  THFunctions.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//



@interface THFunctions : NSObject
extern CGRect THCenterCropImageRect(CGRect sourceRect, CGRect previewRect);
extern CGAffineTransform THTransformForDeviceOrientation(UIDeviceOrientation orientation);
@end
