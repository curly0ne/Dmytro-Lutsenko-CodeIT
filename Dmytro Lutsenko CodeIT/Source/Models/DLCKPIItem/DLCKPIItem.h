//
//  DLCKPIItem.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <Motis/Motis.h>

#import "DLCKPIItemTimePeriod.h"
#import "DLCKPIItemValue.h"
#import "DLCKPISurroundingPeriodValue.h"

@interface DLCKPIItem : NSObject

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) DLCKPIItemTimePeriod *timePeriod;
@property (strong, nonatomic, readonly) DLCKPIItemValue *value;
@property (strong, nonatomic, readonly) DLCKPISurroundingPeriodValue *surroundingPeriodValue;
//@property (strong, nonatomic, readonly) DLCKPIItemValue *surroundingPeriodMinValue;
//@property (strong, nonatomic, readonly) DLCKPIItemValue *surroundingPeriodAvgValue;
//@property (strong, nonatomic, readonly) DLCKPIItemValue *surroundingPeriodMaxValue;

@end
