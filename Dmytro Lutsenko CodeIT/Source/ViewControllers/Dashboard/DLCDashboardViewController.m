//
//  DLCDashboardViewController.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import "DLCDashboardViewController.h"
#import "DLCKPITableViewCell.h"

#import "NSObject+ClassNameString.h"

@interface DLCDashboardViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)adjustTableView;
- (void)deleteKPIItemAtIndex:(NSUInteger)index;

@end

@implementation DLCDashboardViewController

#pragma mark - Overridden

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setHidesBackButton:YES];
    
    [self adjustTableView];
}

#pragma mark - Private

- (void)adjustTableView
{
    UINib *kpiCellNib = [UINib nibWithNibName:[DLCKPITableViewCell classNameString] bundle:[NSBundle mainBundle]];
    [[self tableView] registerNib:kpiCellNib forCellReuseIdentifier:[DLCKPITableViewCell classNameString]];
}

- (void)deleteKPIItemAtIndex:(NSUInteger)index
{
    NSMutableArray *mutableKPIItems = [[self kpiItems] mutableCopy];
    [mutableKPIItems removeObjectAtIndex:index];
    
    [self setKpiItems:[mutableKPIItems copy]];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self kpiItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLCKPITableViewCell *cell = (DLCKPITableViewCell *)[tableView dequeueReusableCellWithIdentifier:[DLCKPITableViewCell classNameString]];
    NSUInteger cellIndex = [indexPath row];
    
    [cell setupWithKPIItem:[self kpiItems][cellIndex]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger itemIndex = [indexPath row];
        [self deleteKPIItemAtIndex:itemIndex];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
