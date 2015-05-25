//
//  UIViewController_SW.m
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 02/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController_SW.h"
 
@implementation UIViewController_SW

- (id)initWithData:(Filtre*) _filtre{
    self = [super init];
    if(self)
    {
        filtre = _filtre;
    }
    return self;
}

-(void) viewDidLoad {
    self.rightViewRevealWidth = (int)(375/2);
    self.navigationItem.hidesBackButton = YES;
    /*
     * Add action event list button (slide out menu)
     */
    SWRevealViewController *revealViewController = self;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.panGestureRecognizer];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // set data for views
    if ([[segue identifier] isEqualToString:@"sw_right"]) {
        UIViewController_Menu *uivMenu = (UIViewController_Menu*)[segue destinationViewController];
        uivMenu->filtre = filtre;
    } else if ([[segue identifier] isEqualToString:@"sw_front"]) {
        UIViewController_Map *uivMap = [(UIViewController_Map*)[segue destinationViewController] initWith:filtre];
    }
}

@end