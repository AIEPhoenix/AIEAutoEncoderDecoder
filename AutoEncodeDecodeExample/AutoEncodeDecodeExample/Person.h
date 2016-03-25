//
//  Person.h
//  AutoEncodeDecodeExample
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef struct{
    int year;
    int month;
    int day;
} BirthDate;
@class Dog;
@interface Person : NSObject
@property (nonatomic, strong) Dog *dog;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) BirthDate birth;
@property (nonatomic, assign) CGSize WH;
-(NSString *)introduce;
@end
