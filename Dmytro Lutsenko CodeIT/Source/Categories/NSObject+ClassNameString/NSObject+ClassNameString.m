//
//  NSObject+ClassNameString.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "NSObject+ClassNameString.h"

@implementation NSObject (ClassNameString)

+ (NSString *)classNameString
{
    return NSStringFromClass(self);
}

@end
