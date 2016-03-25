//
//  Person.m
//  AutoEncodeDecodeExample
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import "Person.h"

@implementation Person
-(NSString *)introduce{
    return [self dictionaryWithValuesForKeys:@[@"dog",
                                               @"age",
                                               @"birth",
                                               @"WH"]].description;
}
@end
