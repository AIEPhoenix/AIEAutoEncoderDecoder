//
//  NSObject+AIEAutoEncoderDecoder.m
//  Resume
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 AIEPhoenix. All rights reserved.
//

#import "NSObject+AIEAutoEncoderDecoder.h"
#import <objc/runtime.h>

@implementation NSObject (AIEAutoEncoderDecoder)

- (void)encodeWithCoder:(NSCoder *)encoder {
    ///  取得欲归档对象类型
    Class cos = [self class];
    ///  向上遍历本类及父类的属性列表进行归档操作(不为NSObject时)
    while (cos != [NSObject class]) {
        unsigned int numberOfIvars =0;
        Ivar * ivars = class_copyIvarList(cos, &numberOfIvars);
        for(const Ivar * p = ivars; p < ivars + numberOfIvars; p++){
            Ivar const ivar = *p;
            const char *type = ivar_getTypeEncoding(ivar);
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [self valueForKey:key];
            if (value) {
                switch (type[0]) {
                        ///  用来处理自定义的结构体成员属性
                    case _C_STRUCT_B: {
                        NSUInteger ivarSize =0;
                        NSUInteger ivarAlignment =0;
                        NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                        NSData *data = [NSData dataWithBytes:(__bridge_retained const void *)self + ivar_getOffset(ivar) length:ivarSize];
                        [encoder encodeObject:data forKey:key];
                    }
                        break;
                    default:
                        [encoder encodeObject:value forKey:key];
                        break;
                }
            }
        }
        free(ivars);
        cos = class_getSuperclass(cos);
    }
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    
    if (self) {
        Class cls = [self class];
        while (cls != [NSObject class]) {
            unsigned int numberOfIvars =0;
            Ivar * ivars = class_copyIvarList(cls, &numberOfIvars);
            
            for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++){
                Ivar const ivar = *p;
                const char *type =ivar_getTypeEncoding(ivar);
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
                id value = [decoder decodeObjectForKey:key];
                if (value) {
                    switch (type[0]) {
                        case _C_STRUCT_B: {
                            NSUInteger ivarSize =0;
                            NSUInteger ivarAlignment =0;
                            NSGetSizeAndAlignment(type, &ivarSize, &ivarAlignment);
                            NSData *data = [decoder decodeObjectForKey:key];
                            const void *sourceheaderLocation = (__bridge_retained const void *)self;
                            void *sourceIvarLocation = (void *)sourceheaderLocation + ivar_getOffset(ivar);
                            [data getBytes:sourceIvarLocation length:ivarSize];
                            CFRelease(sourceheaderLocation);
                        }
                            break;
                        default:
                            [self setValue:[decoder decodeObjectForKey:key]
                                    forKey:key];
                            break;
                    }
                }
            }
            free(ivars);
            cls = class_getSuperclass(cls);
        }
    }
    
    return self;
}
@end