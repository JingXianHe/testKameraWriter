//
//  THPhotoFilters.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//



@interface THPhotoFilters : NSObject
+ (NSArray *)filterNames;
+ (NSArray *)filterDisplayNames;
+ (CIFilter *)filterForDisplayName:(NSString *)displayName;
+ (CIFilter *)defaultFilter;
@end
