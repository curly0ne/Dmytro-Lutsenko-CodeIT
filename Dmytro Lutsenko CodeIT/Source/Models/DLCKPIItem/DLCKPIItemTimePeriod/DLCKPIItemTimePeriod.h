//
//  DLCKPIItemTimePeriod.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Motis/Motis.h>

@interface DLCKPIItemTimePeriod : NSObject

@property (strong, nonatomic, readonly) NSString *unit;
@property (strong, nonatomic, readonly) NSNumber *amount;

@end
