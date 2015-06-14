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
#import <Foundation/Foundation.h>
#import "DownloadTaskSync.h"
#import "Factory.h"
#import "XMLToObjectParser.h"
#import "UIViewController_Date.h"
#import "Filtre.h"

@interface UIViewController_Site : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITableView *myTable;
     __weak IBOutlet UINavigationItem *navBar;
    NSString *url, *datesXML, *infosXML, *path;
    @public
    BOOL isFirstTime;
    Filtre *filtre;
    Factory *factory;
}
-(id)initWithFiltre:(Filtre *)_filtre:(BOOL)_isFirstTime;
// Create array from content xml
- (void) createLocations:(NSData*) xmlContent;
-(void) process:(Site *)_site:(NSIndexPath*)_indexPath;

@end

#endif
