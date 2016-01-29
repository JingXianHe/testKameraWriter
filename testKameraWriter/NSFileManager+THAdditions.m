//
//  NSFileManager+THAdditions.m
//  testKameraWriter
//
//  Created by beihaiSellshou on 1/29/16.
//  Copyright © 2016 JXHDev. All rights reserved.
//

#import "NSFileManager+THAdditions.h"

@implementation NSFileManager (THAdditions)
- (NSString *)temporaryDirectoryWithTemplateString:(NSString *)templateString {
    
    NSString *mkdTemplate =
    [NSTemporaryDirectory() stringByAppendingPathComponent:templateString];
    
    const char *templateCString = [mkdTemplate fileSystemRepresentation];
    char *buffer = (char *)malloc(strlen(templateCString) + 1);
    strcpy(buffer, templateCString);
    
    NSString *directoryPath = nil;
    
    char *result = mkdtemp(buffer);
    if (result) {
        directoryPath = [self stringWithFileSystemRepresentation:buffer
                                                          length:strlen(result)];
    }
    free(buffer);
    return directoryPath;
}
@end
