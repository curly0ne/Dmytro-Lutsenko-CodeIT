//
//  DLCKPIItemValue.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCKPIItemValue.h"

@interface DLCKPIItemValue ()

@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSNumber *amount;

@end

@implementation DLCKPIItemValue

+ (NSDictionary *)mts_mapping
{
    return @{@"unit" : mts_key(unit),
             @"value" : mts_key(amount)};
}

@end
