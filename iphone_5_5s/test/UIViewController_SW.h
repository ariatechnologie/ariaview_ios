//
//  UIViewController_SW.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 02/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_UIViewController_SW_h
#define AriaViewIOS_UIViewController_SW_h
#import "SWRevealViewController.h"
#import "Filtre.h"
#import "UIViewController_Menu.h"
#import "AirModelXml.h"

@class UIViewController_Menu;

@interface UIViewController_SW : SWRevealViewController {
    Factory *factory;
    @public
    Filtre *filtre;
    AirModelXml *airModelXml;
    NSMutableString *pathDirectory;
    UIViewController_Menu *uivMenu;
    UIViewController_Map *map;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button;
- (id)initWithFiltre: (Filtre*) _filtre;
@end
#endif
