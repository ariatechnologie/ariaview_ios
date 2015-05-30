//
//  UIViewController_Pollutant.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 25/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_UIViewController_Pollutant_h
#define AriaViewIOS_UIViewController_Pollutant_h
#import <UIKit/UIKit.h>
#import "Filtre.h"
#import "Factory.h"
#import "AirModelXml.h"
#import "UIViewController_SW.h"

@interface UIViewController_Pollutant : UIViewController <UITableViewDelegate, UITableViewDataSource>  {
    NSString *infosXML, *path;
    __weak IBOutlet UITableView *myTable;
    __weak IBOutlet UINavigationItem *navBar;
    Factory *factory;
    @public
    Filtre *filtre;
}
- (id)initWithFiltre:(Filtre*) _filtre;
@end
#endif
