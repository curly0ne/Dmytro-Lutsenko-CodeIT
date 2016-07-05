//
//  DLCNetworkingGateway.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/5/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCNetworkingGateway.h"
#import "DLCError.h"
#import "DLCKPIResponseParser.h"

NSString *kDLCNetworkErrorDomain = @"NetworkingError";

static NSString * const kDLCLoginRequestURLString = @"https://opx.cfapps.io/dashboarditems";

@interface DLCNetworkingGateway () <NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (strong, nonatomic) NSURLSession *loginSession;
@property (strong, nonatomic) NSDictionary *userCredentials;

@property (copy, nonatomic) CompletionHandler handlerBlock;

- (NSDictionary *)credentialsDictionaryWithLogin:(NSString *)login andPassword:(NSString *)password;
- (DLCError *)processError:(NSError *)error;

@end

@implementation DLCNetworkingGateway

#pragma mark - Overridden

- (NSURLSession *)loginSession
{
    if (_loginSession)
    {
        return _loginSession;
    }
    
    _loginSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                  delegate:self
                                             delegateQueue:[NSOperationQueue mainQueue]];
    
    return _loginSession;
}

#pragma mark - Public

- (void)authenticateUserWithLogin:(NSString *)userLogin password:(NSString *)password andCompletionHandler:(void (^)(id, DLCError *))completionHandler
{
    [self setHandlerBlock:completionHandler];
    
    [self setUserCredentials:[self credentialsDictionaryWithLogin:userLogin
                                                      andPassword:password]];
    
    NSURL *loginURL = [NSURL URLWithString:kDLCLoginRequestURLString];
    NSURLRequest *loginRequest = [NSURLRequest requestWithURL:loginURL];
    
    typeof(self) __weak weakSelf = self;
    
    NSURLSessionDataTask *task = [[self loginSession] dataTaskWithRequest:loginRequest
                                                        completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                  {                                      
                                      if (!error)
                                      {
                                          DLCError *parsingError;
                                          
                                          id response = [DLCKPIResponseParser arrayFromKPIItemsResponseData:data
                                                                                                  withError:&parsingError];
                                          
                                          if (!parsingError)
                                          {
                                              completionHandler(response, nil);
                                          }
                                          else
                                          {
                                              completionHandler(nil, parsingError);
                                          }
                                      }
                                      else
                                      {
                                          completionHandler(nil, [weakSelf processError:error]);
                                      }
                                  }];
    
    [task resume];
}

#pragma mark - Private

- (NSDictionary *)credentialsDictionaryWithLogin:(NSString *)login andPassword:(NSString *)password
{
    NSString *nonNilLogin = login ? : @"";
    NSString *nonNilPassword = password ? : @"";
    
    return @{@"login" : nonNilLogin,
             @"password" : nonNilPassword};
}

- (DLCError *)processError:(NSError *)error
{
    NSUInteger errorCode = [error code];
    
    NSUInteger customErrorCode = 0;

    switch (errorCode)
    {
        case -1003:
        case -1004:
        case -1005:
        case -1008:
        case -1009:
            customErrorCode = 100;
            
            break;
            
        case -999:
            customErrorCode = 101;
            
            break;
            
        default:
            customErrorCode = 199;
    }
    
    return [DLCError errorWithDomain:kDLCNetworkErrorDomain code:customErrorCode];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    if ([challenge previousFailureCount] > 0)
    {
        [task cancel];

        return;
    }
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:[self userCredentials][@"login"]
                                                             password:[self userCredentials][@"password"]
                                                          persistence:NSURLCredentialPersistenceForSession];
    
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}

@end
