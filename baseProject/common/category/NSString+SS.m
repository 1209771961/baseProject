//
//  NSString+SS.m
//  baseProject
//
//  Created by FL S on 2017/10/23.
//  Copyright © 2017 FL S. All rights reserved.
//

#import "NSString+SS.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>

@implementation NSString (SS)
///MD5加密
- (NSString *)ss_MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


///计算单行文字的size,font:字体
- (CGSize)ss_sizewithFont:(UIFont *)font {
    return [self sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
}

///计算多行文字的size，font:字体
- (CGSize)ss_boundingRectwithSize:(CGSize)size withFont:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return rect.size;
}

///设置不同的颜色
- (NSMutableAttributedString*)ss_attriWithRange:(NSRange)range1 color:(UIColor*)color1 range:(NSRange)range2 color:(UIColor*)color2 {
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color2 range:range2];
    if ((range2.length + range2.location) < self.length) {
        [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(range2.location+range2.length, self.length-range2.location-range2.length)];
    }
    
    return attriStri;
}
///设置不同的字号
- (NSMutableAttributedString*)ss_attriWithRange:(NSRange)range1 font:(UIFont*)font1 range:(NSRange)range2 font:(UIFont*)font2 {
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:font1 range:range1];
    [attriStri addAttribute:NSFontAttributeName value:font2 range:range2];
    if ((range2.length + range2.location) < self.length) {
        [attriStri addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(range2.location+range2.length, self.length-range2.location-range2.length)];
    }
    
    return attriStri;
}

///设置不同的字号及颜色带有字号及颜色
- (NSMutableAttributedString*)ss_strAttriWithRange:(NSRange)range andFont:(CGFloat)font1 withColor:(UIColor*)color1 andRange:(NSRange)secondRange andFont:(CGFloat)font2 with:(UIColor*)color2 {
    NSMutableAttributedString* attriStri = [[NSMutableAttributedString alloc] initWithString:self];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:range];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:range];
    [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font2] range:secondRange];
    [attriStri addAttribute:NSForegroundColorAttributeName value:color2 range:secondRange];
    if ((secondRange.length + secondRange.location) < self.length) {
        [attriStri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font1] range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
        [attriStri addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(secondRange.location+secondRange.length, self.length-secondRange.location-secondRange.length)];
    }
    
    return attriStri;
}


///将url地址中所带的参数转换为字典 格式k1=v1&k2=v2
- (NSDictionary *)ss_dicFromStr {
    NSArray *compents = [self componentsSeparatedByString:@"&"];
    if (!compents.count) {
        return [NSDictionary dictionary];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    for (id obj in compents) {
        if ([obj isKindOfClass:[NSString class]] && [(NSString *)obj containsString:@"="]) {
            NSString *str = (NSString *)obj;
            NSArray *strs = [str componentsSeparatedByString:@"="];
            //            NSString *value = [[strs objectAtArrayIndex:1] empty] ? @"" : [strs objectAtArrayIndex:1];
            [params setObject:[strs SSobjectAtArrayIndex:1] forKey:[strs SSobjectAtArrayIndex:0]];
        }
    }
    return params;
}

///字符串转数组;str:字符串中的分割符（比如：, - 等等）
- (NSArray*)ss_arrFromStrByStr:(NSString*)str {
    NSArray* array = [self componentsSeparatedByString:str];
    return array;
}


///格式化金额字符串，小数点前每三位之间加,
- (NSString *)ss_moneyStr {
    if ([self empty]) {
        return @"0";
    }
    NSArray *range = [[self ss_numStr] componentsSeparatedByString:@"."];
    NSString *str = range[0];
    NSMutableArray *nums = [NSMutableArray arrayWithCapacity:0];
    int j = 0;
    for (NSInteger i = str.length - 1; i >= 0 ; i--) {
        NSString *s = [str substringWithRange:NSMakeRange(i, 1)];
        j++;
        [nums insertObject:s atIndex:0];
        if (j == 3  && i > 0) {
            [nums insertObject:@"," atIndex:0];
            j = 0;
        }
    }
    
    NSString *result = [nums componentsJoinedByString:@""];
    if (range.count == 2) {
        result = [result stringByAppendingFormat:@".%@",range[1]];
    }
    return result;
}

///格式化银行卡号 四位空格
- (NSString *)ss_bankCodeStr {
    if ([self empty]) {
        return @"";
    }
    if (self.length <=4) {
        return self;
    }
    NSMutableArray *charaters = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < self.length; i++) {
        NSString *charater = [self substringWithRange:NSMakeRange(i, 1)];
        [charaters addObject:charater];
        if (i%4 == 3) {
            [charaters addObject:@" "];
        }
    }
    return [charaters componentsJoinedByString:@""];
}

///格式化金额字符串，不足万的显示原值，反之处理成以万为单位
- (NSString *)ss_amountStr {
    if ([self empty]) {
        return @"0";
    }
    double value = self.doubleValue;
    double result = value/10000.0;
    if (result >= 1.0) {
        return [[[NSString stringWithFormat:@"%0.2f",result] ss_numStr] stringByAppendingString:@"万元"];
    }
    return [[[NSString stringWithFormat:@"%0.2f",value] ss_numStr] stringByAppendingString:@"元"];
}

///去除字符串中的html标签
- (NSString *)ss_stringByTrimmingHTMLCharacters {
    if ([self empty]){
        return @"";
    }
    NSRange r;
    NSString *s = [[self stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}


///格式化数字字符串，保留两位小数，并去除末尾的0
-(NSString *)ss_numStr {
    
    if (!self || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return self;
    }
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
//    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *num = [format numberFromString:self];
//    NSString *str = [NSString stringWithFormat:@"%0.2f",num.doubleValue];
//    NSRange range = [str rangeOfString:@"."];
//    if (range.location == !NSNotFound) {
//        return self;
//    }
//    //去除末尾的0，获取剪切位置
//    NSInteger loc = str.length ;
//    for (NSInteger i = str.length - 1; i > range.location; i--) {
//        int a = [str characterAtIndex:i];
//        if (a == 48) {
//            loc--;
//        }else{
//            break;
//        }
//    }
//    str = [str substringToIndex:loc];
//    //如果末尾为.去除末尾的.
//    if ([str rangeOfString:@"."].location == str.length - 1) {
//        return [str substringToIndex:str.length - 1];
//    }
    return [NSString stringWithFormat:@"%@",num];
}

- (BOOL)empty {
    if (!self || [self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        return YES;
    }
    return NO;
}

/**
 *  生成助记字符串
 *  strlength   指定的长度
 *  language    指定的语言 如：english 文件地址    english.txt 支持：简体中文、繁体中文、英文、法文、意大利文、日文、韩文、西班牙文
 */
+ (NSString*)SS_getMnemonicStr:(NSNumber*)strLength language:(NSString*)language {
    if ([strLength integerValue] % 32 != 0) {
        [NSException raise:@"Strength must be divisible by 32" format:@"Strength Was: %@",strLength];
    }
    NSMutableData* bytes = [NSMutableData dataWithLength:[strLength integerValue] / 8];
    //生成随机data
    int status = SecRandomCopyBytes(kSecRandomDefault, bytes.length, bytes.mutableBytes);
    if (status == 0) {
        NSString* hexStr = [bytes SS_hexStr];
        return [self SS_getMnemonicWordFromeHexStr:hexStr language:language];
    }else {
        [NSException raise:@"Unable to get random data!" format:@"Unable to get random data!"];
    }
    
    return nil;
}

/**
 *  16进制字符串生成助记词
*/
+ (NSString*)SS_getMnemonicWordFromeHexStr:(NSString*)hexStr language:(NSString*)language {
    NSData* seedData = [hexStr SS_hexStrToData];
    //计算 sha256 哈希
    NSMutableData *hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(seedData.bytes, (int)seedData.length, hash.mutableBytes);
    
    NSMutableArray *checkSumBits = [NSMutableArray arrayWithArray:[[NSData dataWithData:hash] SS_toBitArray]];
    NSMutableArray *seedBits = [NSMutableArray arrayWithArray:[seedData SS_toBitArray]];
    
    for(int i = 0 ; i < (int)seedBits.count / 32 ; i++) {
        [seedBits addObject:checkSumBits[i]];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@.txt",[[NSBundle mainBundle] bundlePath], language];
    NSString *fileText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lines = [fileText componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *words = [NSMutableArray arrayWithCapacity:(int)seedBits.count / 11];
    
    for(int i = 0 ; i < (int)seedBits.count / 11 ; i++) {
        NSUInteger wordNumber = strtol([[[seedBits subarrayWithRange:NSMakeRange(i * 11, 11)] componentsJoinedByString:@""] UTF8String], NULL, 2);
        
        [words addObject:lines[wordNumber]];
    }
    
    return [words componentsJoinedByString:@" "];
}

- (NSData*)SS_hexStrToData {
    const char *chars = [self UTF8String];
    int i = 0, len = (int)self.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len/2.0];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}

@end
