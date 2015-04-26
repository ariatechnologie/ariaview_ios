//
//  UIViewController_Date.h
//  test
//
//  Created by BOUSSAADIA AMIR on 23/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_UIViewController_Date_h
#define test_UIViewController_Date_h
#import <UIKit/UIKit.h>
#import "XMLToObjectParser.h"
#import "Site.h"

@interface UIViewController_Date : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *myDates;
    __weak IBOutlet UITableView *myTable;
    NSString *name;
    NSInteger *intervalTime;
    NSString *modelLocalOffset;
}

// Create array from content xml
- (void) createDates:(NSData*) xmlContent;

@end

#endif
