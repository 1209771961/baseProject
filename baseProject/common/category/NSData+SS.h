//
//  NSData+SS.h
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SS)
#pragma ------------base64--------------
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;
@end

