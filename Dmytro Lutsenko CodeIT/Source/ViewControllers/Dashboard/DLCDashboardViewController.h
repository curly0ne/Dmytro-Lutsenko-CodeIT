//
//  DLCDashboardViewController.h
//  Dmytro Lutsenko CodeIT
//
//  Created by Dmytro Lutsenko on 7/4/16.
//  Copyright © 2016 CodeIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLCKPIItem;

@interface DLCDashboardViewController : UIViewController

@property (copy, nonatomic) NSArray<DLCKPIItem *> *kpiItems;

@end
