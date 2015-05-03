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
#import "Factory.h"
#import <Foundation/Foundation.h>
#import "XMLToObjectParser.h"
#import "UIViewController_Date.h"
#import "Filtre.h"

@interface UIViewController_Site : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITableView *myTable;
    NSString *url, *urlStub, *datesXML, *infosXML, *path;
    @public
    Filtre *filtre;
    Factory *factory;
    NSMutableArray *myLocations; // Location for one customer
}

// Create array from content xml
- (void) createLocations:(NSData*) xmlContent;

@end

#endif
