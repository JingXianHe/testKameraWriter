//
//  THContextManager.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THContextManager : NSObject
+ (instancetype)sharedInstance;

@property (strong, nonatomic, readonly) EAGLContext *eaglContext;
@property (strong, nonatomic, readonly) CIContext *ciContext;
@end
