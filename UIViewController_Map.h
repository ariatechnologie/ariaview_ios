//
//  UIViewController_Error.h
//  test
//
//  Created by BOUSSAADIA AMIR on 28/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_UIViewController_Error_h
#define test_UIViewController_Error_h

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "SWRevealViewController.h"
#import "Filtre.h"

@interface UIViewController_Map : UIViewController<SWRevealViewControllerDelegate>  {
    
    __weak IBOutlet UIBarButtonItem *sidebarButton;
    @public Filtre *filtre;
}
@end

#endif
