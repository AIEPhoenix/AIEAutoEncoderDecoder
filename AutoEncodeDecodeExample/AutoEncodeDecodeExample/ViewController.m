//
//  ViewController.m
//  AutoEncodeDecodeExample
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

#import "ViewController.h"
#import "AutoEncodeDecodeExample-Swift.h"
#import "Person.h"
#import "Dog.h"
@interface ViewController ()
@property (nonatomic, copy) NSString *filePath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"person.data"];
    
    Bone *bone = [[Bone alloc]init];
    bone.taste = @"咸";
    
    Person *person = [[Person alloc]init];
    
    Dog *dog = [[Dog alloc]init];
    dog.bone = bone;
    dog.host = person;
    
    person.dog = dog;
    person.age = 18;
    BirthDate birth = {1999,11,11};
    person.birth = birth;
    person.WH = CGSizeMake(40, 180);
    
    [NSKeyedArchiver archiveRootObject:person toFile:self.filePath];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    Person *unArchivePerson = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    NSLog(@"Person对象地址%p",unArchivePerson);
    NSLog(@"%@",[unArchivePerson introduce]);
    NSLog(@"其中的自定义结构体值birthdate year:%d month:%d day:%d",unArchivePerson.birth.year,unArchivePerson.birth.month,unArchivePerson.birth.day);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
