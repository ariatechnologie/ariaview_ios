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
    __weak IBOutlet UINavigationItem *navBar;
    NSString *name, *infosXML, *path;
    NSInteger *intervalTime;
    NSString *modelLocalOffset;
    Factory *factory;
    @public
    Filtre *filtre;
    BOOL isFirstTime;
}
-(id)initWithFiltre:(Filtre *)_filtre:(BOOL)_isFirstTime;
// Create array from content xml
- (void) createDates:(NSData*) xmlContent;
-(void) process:(NSString *)_date: (NSIndexPath*)_indexPath;

@end

#endif
