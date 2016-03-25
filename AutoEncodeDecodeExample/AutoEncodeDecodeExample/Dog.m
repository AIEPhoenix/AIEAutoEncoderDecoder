//
//  Dog.m
//  AutoEncodeDecodeExample
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import "Dog.h"

@implementation Dog
-(NSString *)description{
    return [self dictionaryWithValuesForKeys:@[@"bone",
                                               @"host"
                                               ]].description;
}
@end
