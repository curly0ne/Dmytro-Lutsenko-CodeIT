//
//  DLCError.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/5/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCError.h"

@interface DLCError ()

@property (strong, nonatomic) NSString *domain;
@property (nonatomic) NSUInteger code;

@end

@implementation DLCError

#pragma mark - Public

+ (DLCError *)errorWithDomain:(NSString *)domain code:(NSUInteger)code
{
    DLCError *error = [DLCError new];
    
    [error setDomain:domain];
    [error setCode:code];
    
    return error;
}

@end

