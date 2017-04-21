//
//  LEFoundation.m
//  Pods
//
//  Created by emerson larry on 2016/11/28.
//
//

#import "LEFoundation.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LEWeakReferenceWrapper {
    __weak id weakReference;
}
+(id) leWrapNonretainedObject:(id)obj {
    return [[LEWeakReferenceWrapper alloc] initWithNonretainedObject:obj];
}
-(id) init {
    return [self initWithNonretainedObject:nil];
}
-(id) initWithNonretainedObject:(id)obj {
    self = [super init];
    if (self) {
        weakReference = obj;
    }
    return self;
}
-(id) leGet {
    return weakReference;
}
@end

@implementation NSObject (LEFoundation)
-(NSString *) leStringValue{
    return [NSString stringWithFormat:@"%@",self];
}
//-(void) leExtraInits{
//    [self leAdditionalInits];
//}
-(void) leAdditionalInits{}
-(void) leRelease{}
-(void(^)()) leReleased{
    return ^void(){
        [self leRelease];
    };
}

+(instancetype) leNew{
    return [[self class] new];
}
-(void(^)()) leEnd{
    return ^void(){};
}
-(NSString *) leObjToJSONString{
    NSString *jsonString = @"";
    if([[[UIDevice currentDevice].name lowercaseString] rangeOfString:@"simulator"].location !=NSNotFound){
        if([self isKindOfClass:[NSDictionary class]]||[self isMemberOfClass:[NSDictionary class]]){
            jsonString = [NSObject JSONStringWithDictionary:(NSDictionary *)self];
        }else if([self isKindOfClass:[NSArray class]]||[self isMemberOfClass:[NSArray class]]){
            jsonString = [NSObject JSONStringWithArray:(NSArray *)self];
        }
    }else{
        NSError *error=nil;
        if([NSJSONSerialization isValidJSONObject:self]){
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
            if (jsonData) {
                jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            }
        }
    }
    if(jsonString){
        jsonString=[jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    return jsonString;
}
+(NSString*) JSONStringWithDictionary:(NSDictionary *) dic {
    NSMutableString *jsonString=[[NSMutableString alloc] initWithString:@""];
    NSString *value=nil;
    for (NSString *key in dic.allKeys) {
        if(value){
            if(jsonString.length>0){
                [jsonString appendString:@","];
            }
        }
        id obj=[dic objectForKey:key];
        if([obj isKindOfClass:[NSDictionary class]]){
            value=[self JSONStringWithDictionary:obj];
            [jsonString appendFormat:@" \"%@\":%@", key, value];
        }else if([obj isKindOfClass:[NSArray class]]){
            value=[self JSONStringWithArray:obj];
            [jsonString appendFormat:@" \"%@\":%@", key, value];
        }else {
            value=[NSString stringWithFormat:@"%@",obj];
            value=[value stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
            value=[value stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
            value=[value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            value=[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [jsonString appendFormat:@" \"%@\":\"%@\"", key, value];
        }
    }
    [jsonString insertString:@"{" atIndex:0];
    [jsonString appendString:@"}"];
    return jsonString;
}
+(NSString*) JSONStringWithArray:(NSArray *) array {
    NSMutableString *jsonString=[[NSMutableString alloc] initWithString:@""];
    for (int i=0; i<array.count; i++) {
        id obj=[array objectAtIndex:i];
        if([obj isKindOfClass:[NSDictionary class]]||[obj isKindOfClass:[NSMutableDictionary class]]){
            if(jsonString.length>0){
                [jsonString appendFormat:@",%@",[(NSDictionary *)obj leObjToJSONString]];
            }else{
                [jsonString appendString:[(NSDictionary *)obj leObjToJSONString]];
            }
        }else {
            if(jsonString.length>0){
                [jsonString appendFormat:@",\"%@\"",obj];
            }else {
                [jsonString appendFormat:@"\"%@\"",obj];
            }
        }
    }
    [jsonString insertString:@"[" atIndex:0];
    [jsonString appendString:@"]"];
    return jsonString;
}
//

@end

@implementation NSString (LEFoundation)
-(int) leAsciiLength{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [self dataUsingEncoding:enc];
    return (int)[da length];
}
-(NSString *) leGetTrimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSObject *) leGetInstanceFromClassName{
    Class class=[self leClass];
    return class?[class alloc]:nil;
}
-(Class) leClass{
    Class class=NSClassFromString(self);
    NSAssert(class!=[NSNull null],([NSString stringWithFormat:@"请检查类名是否正确：%@",self]));
    return class;
}
-(id)leJSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
-(NSString *)leMd5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the leMd5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
-(NSString *)leMd5WithSalt:(NSString *) salt{
    return [[[self leMd5] stringByAppendingString:salt] leMd5];
}
-(NSString *)leBase64Encoder{
    NSData *data=[self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
-(NSString *)leBase64Decoder{
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}
@end


