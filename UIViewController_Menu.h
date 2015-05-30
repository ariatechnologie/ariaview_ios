//
//  UIViewController_Menu.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 02/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_UIViewController_Menu_h
#define AriaViewIOS_UIViewController_Menu_h
#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "UIViewController_Site.h"
#import "UIViewController_Date.h"
#import "UIViewController_Auth.h"
#import "Filtre.h"
#import "Factory.h"

@interface UIViewController_Menu : UIViewController  <UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITableView *tableViewMenu;
    NSMutableArray *myOptions;
    int CHANGE_SITE, CHANGE_DATE, SIGNOUT, CHANGE_POLLUTANT;
    Factory *factory;
    @public
    Filtre *filtre;
}
@end
#endif
