//
//  DLCNetworkingGateway.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/5/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DLCError;

typedef void (^CompletionHandler)(id response, DLCError *error);

@interface DLCNetworkingGateway : NSObject

- (void)authenticateUserWithLogin:(NSString *)userLogin
                         password:(NSString *)password
             andCompletionHandler:(CompletionHandler)completionHandler;

@end
