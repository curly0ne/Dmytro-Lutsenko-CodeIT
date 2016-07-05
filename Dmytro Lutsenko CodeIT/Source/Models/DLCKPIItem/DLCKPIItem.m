//
//  DLCKPIItem.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCKPIItem.h"

@interface DLCKPIItem ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) DLCKPIItemTimePeriod *timePeriod;
@property (strong, nonatomic) DLCKPIItemValue *value;
@property (strong, nonatomic) DLCKPISurroundingPeriodValue *surroundingPeriodValue;

//@property (strong, nonatomic) DLCKPIItemValue *surroundingPeriodMinValue;
//@property (strong, nonatomic) DLCKPIItemValue *surroundingPeriodAvgValue;
//@property (strong, nonatomic) DLCKPIItemValue *surroundingPeriodMaxValue;

@end

@implementation DLCKPIItem

+ (NSDictionary *)mts_mapping
{
    return @{@"label" : mts_key(name),
             @"kpiValue.timePeriod": mts_key(timePeriod),
             @"kpiValue.amountInAggregationCurrency" : mts_key(value),
             @"surroundingPeriodData" : mts_key(surroundingPeriodValue)};
}

@end
