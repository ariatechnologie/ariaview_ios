//
//  UIViewController_Site.h
//  test
//
//  Created by BOUSSAADIA AMIR on 15/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_UIViewController_Site_h
#define test_UIViewController_Site_h

#import <UIKit/UIKit.h>
#import "DownloadTaskSync.h"

@interface UIViewController_Site : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *myLocations; // Location for one customer
    __weak IBOutlet UITableView *myTable;
    NSString *url;
    NSString *urlBouchon;
    NSString *datesXML;
    NSString *infosXML;
    NSString *path;
}

// Create array from content xml
- (void) createLocations:(NSData*) xmlContent;

@end

#endif
