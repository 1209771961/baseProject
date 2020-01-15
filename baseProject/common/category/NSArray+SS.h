//
//  NSArray+SS.h
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SS)

- (id)SSarrayAtIndex:(NSInteger)index;

- (id)SSdicAtIndex:(NSInteger)index;

- (id)SSstringAtIndex:(NSInteger)index;

- (id)SSobjectAtArrayIndex:(NSUInteger)index;
///将数组元素序列化成NSData
- (NSData *)SStransferToData;
///数组转JSON字符串
- (NSString*)SSarrayToJSONString;

@end

NS_ASSUME_NONNULL_END
