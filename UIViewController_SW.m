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

- (id)initWithFiltre:(Filtre*) _filtre {
    self = [super init];
    if(self) {
        filtre = _filtre;
    }
    return self;
}

-(void) viewDidLoad {
    factory = [[Factory alloc] initWithLanguage:filtre->indexLanguage];
    [menuButton setTitle:factory->menuButtonText];
    NSMutableString *title = [[NSMutableString alloc] init];
    
    NSString *date = filtre->date;
    
    NSString *year, *month, *day;
    year = [date substringToIndex:4];
    month = [[date substringToIndex:6] substringFromIndex:4];
    day = [date substringFromIndex:6];
    
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setYear:[year integerValue]];
    [dc setMonth:[month integerValue]];
    [dc setDay:[day integerValue]];
    
    date = [NSString stringWithFormat:@"%@/%@/%@", day, month, year];
    
    Pollutant *pollutant = [filtre->site->myPollutants objectAtIndex:filtre->indexPollutant];
    [title appendString:@"["];
    [title appendString:date];
    [title appendString:@"] : "];
    [title appendString:pollutant->polutionInterval->name];
    
    navBar.title = [NSString stringWithString:title];;
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