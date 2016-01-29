//
//  NSString+THAdditions.h
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//



@interface NSString (THAdditions)
- (NSString *)stringByMatchingRegex:(NSString *)regex capture:(NSUInteger)capture;
- (BOOL)containsString:(NSString *)substring;
@end
