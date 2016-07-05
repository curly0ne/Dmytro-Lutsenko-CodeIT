//
//  DLCKPIResponseParser.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLCKPIItem, DLCError;

@interface DLCKPIResponseParser : NSObject

+ (NSArray<DLCKPIItem *> *)arrayFromKPIItemsResponseData:(NSData *)kpiItemsData withError:(DLCError **)error;

@end
