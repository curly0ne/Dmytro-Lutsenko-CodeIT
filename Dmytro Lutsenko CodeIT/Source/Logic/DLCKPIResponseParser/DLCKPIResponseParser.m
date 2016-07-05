//
//  DLCKPIResponseParser.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCKPIResponseParser.h"
#import "DLCKPIItem.h"
#import "DLCError.h"

NSString *kDLCDataProcessingErrorDomain = @"DataProcessingError";

@implementation DLCKPIResponseParser

#pragma mark - Public

+ (NSArray<DLCKPIItem *> *)arrayFromKPIItemsResponseData:(NSData *)kpiItemsData withError:(DLCError *__autoreleasing *)error
{
    NSError *serializationError;
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:kpiItemsData
                                                         options:kNilOptions
                                                           error:&serializationError];
    
    if (!serializationError)
    {
        NSMutableArray<DLCKPIItem *> *kpiItemsArray = [NSMutableArray array];
        
        [jsonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             if ([obj isKindOfClass:[NSDictionary class]])
             {
                 DLCKPIItem *kpiItem = [DLCKPIItem new];
                 [kpiItem mts_setValuesForKeysWithDictionary:obj];
                 
                 [kpiItemsArray addObject:kpiItem];
             }
         }];
        
        return [kpiItemsArray copy];

    }
    
    *error = [DLCError errorWithDomain:kDLCDataProcessingErrorDomain code:200];

    return nil;
}

@end
