//
//  DLCLoginViewController.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

#import "DLCLoginViewController.h"
#import "DLCDashboardViewController.h"
#import "DLCKPIResponseParser.h"
#import "DLCNetworkingGateway.h"
#import "DLCError.h"

#import "NSObject+ClassNameString.h"

@interface DLCLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (strong, nonatomic) DLCNetworkingGateway *networkingGateway;

@property (strong, nonatomic) NSDictionary *userCredentials;
@property (strong, nonatomic) id response;

- (void)performLogin;
- (void)handleError:(DLCError *)error;

@end

@implementation DLCLoginViewController

#pragma mark - Overridden

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNetworkingGateway:[DLCNetworkingGateway new]];
}

#pragma mark - Private

- (void)performLogin
{
    typeof(self) __weak weakSelf = self;
    
    NSString *login = [[self loginTextField] text];
    NSString *password = [[self passwordTextField] text];
    
    [SVProgressHUD show];
    
    [[self networkingGateway] authenticateUserWithLogin:login
                                               password:password
                                   andCompletionHandler:^(id response, DLCError *error)
                                    {
                                        [SVProgressHUD dismiss];
                                        
                                        if (!error)
                                        {
                                            [weakSelf setResponse:response];
                                            
                                            [weakSelf performSegueWithIdentifier:[DLCDashboardViewController classNameString]
                                                                          sender:weakSelf];
                                        }
                                        else
                                        {
                                            [weakSelf handleError:error];
                                        }
                                    }];
}

- (void)handleError:(DLCError *)error
{
    NSUInteger errorCode = [error code];
    
    NSString *alertTitle = @"Error";
    NSString *alertMessage;
    
    switch (errorCode)
    {
        case 100:
            alertMessage = @"Failed to obtain data. Please check your network connection.";
            
            break;
            
        case 101:
            alertMessage = @"Incorrect login and/or password.";
            
            break;
            
        case 199:
            alertMessage = @"An error occured on the server.";
            
            break;
            
        case 200:
            alertMessage = @"Failed to process data";
            
            break;
            
        default:
            alertMessage = @"Unknown error occured.";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:alertMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok"
                                                     style:UIAlertActionStyleDefault
                                                   handler:NULL];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:NULL];
}

#pragma mark - Actions

- (IBAction)onSubmitButton:(id)sender
{
    [self performLogin];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:[DLCDashboardViewController classNameString]])
    {
        DLCDashboardViewController *dashboardVC = (DLCDashboardViewController *)[segue destinationViewController];
        [dashboardVC setKpiItems:[self response]];
    }
}

@end
