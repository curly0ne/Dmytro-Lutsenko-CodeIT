//
//  DLCKPITableViewCell.m
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <YLProgressBar/YLProgressBar.h>

#import "DLCKPITableViewCell.h"
#import "DLCKPIItem.h"

@interface DLCKPITableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timePeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet YLProgressBar *valueBar;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;

- (void)adjustProgressBarWithSurroundingPeriodValues:(DLCKPISurroundingPeriodValue *)surroundingPeriodValues;
- (void)adjustTimePeriodLabelWithTimePeriod:(DLCKPIItemTimePeriod *)timePeriod;
- (void)adjustValueLabelWithValue:(DLCKPIItemValue *)value;
- (NSString *)mapCurrencyAbbreviationToCurrencySign:(NSString *)currencyAbbreviation;

@end

@implementation DLCKPITableViewCell

#pragma mark - Overridden

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - Public

- (void)setupWithKPIItem:(DLCKPIItem *)kpiItem
{
    [[self titleLabel] setText:[kpiItem name]];
    [self adjustTimePeriodLabelWithTimePeriod:[kpiItem timePeriod]];
    [self adjustValueLabelWithValue:[kpiItem value]];
    [self adjustProgressBarWithSurroundingPeriodValues:[kpiItem surroundingPeriodValue]];
}

#pragma mark - Private

- (void)adjustTimePeriodLabelWithTimePeriod:(DLCKPIItemTimePeriod *)timePeriod
{
    NSMutableString *timeUnit = [[timePeriod unit] mutableCopy];
    
    if ([[timePeriod amount] integerValue] != 1)
    {
        [timeUnit appendString:@"s"];
    }
    
    NSString *finalTimePeriodString = [NSString stringWithFormat:@"%@ %@", [timePeriod amount], timeUnit];
    
    [[self timePeriodLabel] setText:finalTimePeriodString];
}

- (void)adjustValueLabelWithValue:(DLCKPIItemValue *)value
{
    NSString *currency = [self mapCurrencyAbbreviationToCurrencySign:[value unit]];
    
    [[self valueLabel] setText:[NSString stringWithFormat:@"value: %@ %@", [value amount], currency]];
}

- (NSString *)mapCurrencyAbbreviationToCurrencySign:(NSString *)currencyAbbreviation
{
    if ([[currencyAbbreviation lowercaseString] isEqualToString:@"eur"])
    {
        return @"€";
    }
    
    return @"$";
}

- (void)adjustProgressBarWithSurroundingPeriodValues:(DLCKPISurroundingPeriodValue *)surroundingPeriodValues
{
    NSString *minValueString = [NSString stringWithFormat:@"%@", [surroundingPeriodValues minValue]];
    NSString *avgValueString = [NSString stringWithFormat:@"%@", [surroundingPeriodValues avgValue]];
    NSString *maxValueString = [NSString stringWithFormat:@"%@", [surroundingPeriodValues maxValue]];
    
    CGFloat minValueFloat = [[surroundingPeriodValues minValue] floatValue];
    CGFloat avgValueFloat = [[surroundingPeriodValues avgValue] floatValue];
    CGFloat maxValueFloat = [[surroundingPeriodValues maxValue] floatValue];
    
    [[self minLabel] setText:minValueString];
    [[self maxLabel] setText:maxValueString];

    [[self valueBar] setProgress:(avgValueFloat - minValueFloat) / (maxValueFloat - minValueFloat)];
    [[self valueBar] setIndicatorTextDisplayMode:YLProgressBarIndicatorTextDisplayModeProgress];
    
    [[[self valueBar] indicatorTextLabel] setLineBreakMode:NSLineBreakByTruncatingTail];
    [[[self valueBar] indicatorTextLabel] setText:avgValueString];
}

@end
