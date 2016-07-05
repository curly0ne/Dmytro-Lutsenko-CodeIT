//
//  DLCError.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/5/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *kDLCNetworkErrorDomain;
FOUNDATION_EXPORT NSString *kDLCDataProcessingErrorDomain;

@interface DLCError : NSObject

@property (strong, nonatomic, readonly) NSString *domain;
@property (nonatomic, readonly) NSUInteger code;

+ (DLCError *)errorWithDomain:(NSString *)domain code:(NSUInteger)code;

@end
