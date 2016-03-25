//
//  Dog.h
//  AutoEncodeDecodeExample
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person,Bone;
@interface Dog : NSObject
@property (nonatomic, strong) Bone *bone;
@property (nonatomic, weak) Person *host;
@end
