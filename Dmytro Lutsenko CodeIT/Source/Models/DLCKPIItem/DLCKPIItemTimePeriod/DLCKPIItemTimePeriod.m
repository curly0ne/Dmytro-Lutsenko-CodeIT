//
//  DLCKPIItemTimePeriod.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCKPIItemTimePeriod.h"

@interface DLCKPIItemTimePeriod ()

@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSNumber *amount;

@end

@implementation DLCKPIItemTimePeriod

+ (NSDictionary *)mts_mapping
{
    return @{@"sliceUnit" : mts_key(unit),
             @"sliceUnitCount" : mts_key(amount)};
}

@end
