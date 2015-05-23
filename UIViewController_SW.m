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

- (id)initWithIndexInterval:(int) _index {
    self = [super init];
    if(self)
    {
        indexInterval = _index;
    }
    return self;
}

-(void) viewDidLoad {
    self.rightViewRevealWidth = 190;
    self.navigationItem.hidesBackButton = YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // set data for views
    if ([[segue identifier] isEqualToString:@"sw_right"]) {
        UIViewController_Menu *uivMenu = (UIViewController_Menu*)[segue destinationViewController];
        uivMenu->filtre = filtre;
    } else if ([[segue identifier] isEqualToString:@"sw_front"]) {
        UIViewController_Map *uivMap = [(UIViewController_Map*)[segue destinationViewController] initWithIndexInterval:indexInterval];
        uivMap->airModelXml = airModelXml;
        uivMap->filtre = filtre;
        uivMap->pathDirectory = pathDirectory;
    }
}

@end