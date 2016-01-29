//
//  THPhotoFilters.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "THPhotoFilters.h"
#import "NSString+THAdditions.h"
@implementation THPhotoFilters
+ (NSArray *)filterNames {
    
    return @[@"CIPhotoEffectMono",
             @"CIPhotoEffectFade",
             @"CIPhotoEffectInstant",
             @"CIPhotoEffectMono",
             @"CIPhotoEffectNoir",
             @"CIPhotoEffectProcess",
             @"CIPhotoEffectTonal",
             @"CIPhotoEffectTransfer"];
}
+ (NSArray *)filterDisplayNames {
    
    NSMutableArray *displayNames = [NSMutableArray array];
    
    for (NSString *filterName in [self filterNames]) {
        [displayNames addObject:[filterName stringByMatchingRegex:@"CIPhotoEffect(.*)" capture:1]];
    }
    
    return displayNames;
}

+ (CIFilter *)defaultFilter {
    return [CIFilter filterWithName:[[self filterNames] firstObject]];
}

+ (CIFilter *)filterForDisplayName:(NSString *)displayName {
    for (NSString *name in [self filterNames]) {
        if ([name containsString:displayName]) {
            return [CIFilter filterWithName:name];
        }
    }
    return nil;
}

@end
