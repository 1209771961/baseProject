//
//  NSDictionary+SS.h
//  baseProject
//
//  Created by FL S on 2019/10/23.
//  Copyright © 2019 FL S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SS)

- (id)SSarrayForDicKey:(NSString*)key;

- (id)SSdicForDicKey:(NSString*)key;

- (id)SSstringForDicKey:(NSString*)key;

- (BOOL)SSboolForDicKey:(NSString*)key;

- (id)SSobjectForDictKey:(id)key;

- (NSString *)SSdictionryToJSONString;

- (NSData *)SStransferToData;

- (NSDictionary *)SSdeleteEmptyValue;

@end


