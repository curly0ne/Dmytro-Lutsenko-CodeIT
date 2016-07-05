//
//  DLCKPISurroundingPeriodValue.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCKPISurroundingPeriodValue.h"

@interface DLCKPISurroundingPeriodValue ()

@property (strong, nonatomic) NSNumber *minValue;
@property (strong, nonatomic) NSNumber *avgValue;
@property (strong, nonatomic) NSNumber *maxValue;

@end

@implementation DLCKPISurroundingPeriodValue

+ (NSDictionary *)mts_mapping
{
    return @{@"minValue.amountInAggregationCurrency.value" : mts_key(minValue),
             @"avgValue.amountInAggregationCurrency.value" : mts_key(avgValue),
             @"maxValue.amountInAggregationCurrency.value" : mts_key(maxValue)};
}

@end
