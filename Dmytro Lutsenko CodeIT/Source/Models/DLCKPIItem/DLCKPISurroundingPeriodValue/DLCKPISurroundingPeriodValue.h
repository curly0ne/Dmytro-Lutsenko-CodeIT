//
//  DLCKPISurroundingPeriodValue.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Motis/Motis.h>

@interface DLCKPISurroundingPeriodValue : NSObject

@property (strong, nonatomic, readonly) NSNumber *minValue;
@property (strong, nonatomic, readonly) NSNumber *avgValue;
@property (strong, nonatomic, readonly) NSNumber *maxValue;

@end
