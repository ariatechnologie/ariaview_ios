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
#import "Filtre.h"
#import "Factory.h"
#import "UIViewController_Map.h"
#import "UIViewController_Pollutant.h"
#import "AirModelXml.h"

@interface UIViewController_Date : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITableView *myTable;
    NSString *name, *infosXML, *path;
    NSInteger *intervalTime;
    NSString *modelLocalOffset;
    Factory *factory;
    @public
    Filtre *filtre;
}

// Create array from content xml
- (void) createDates:(NSData*) xmlContent;

@end

#endif
