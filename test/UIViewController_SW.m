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
    if(self) {
        filtre = _filtre;
    }
    return self;
}

-(void) viewDidLoad {
    factory = [[Factory alloc] initWithLanguage:filtre->indexLanguage];
//    [button setTitle:factory->menuButtonText];
    
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
    
    NSMutableString *title = [[NSMutableString alloc] init];
    Pollutant *pollutant = [filtre->site->myPollutants objectAtIndex:filtre->indexPollutant];
    [title appendString:@"["];
    [title appendString:date];
    [title appendString:@"] : "];
    [title appendString:pollutant->polutionInterval->name];
    
    /*
     * Add action event list button (slide out menu)
     */
    SWRevealViewController *revealViewController = self->map.revealViewController;
    NSLog(@"revealViewController=%@", revealViewController);
    if ( revealViewController )
    {
        [self.button setTarget: revealViewController];
        [self.button setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
    }

    [self.navigationItem setTitle:[NSString stringWithString:title]];
    self.rearViewRevealWidth = (200);
    self.navigationItem.hidesBackButton = YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // set data for views
    if ([[segue identifier] isEqualToString:@"sw_rear"]) {
        uivMenu = (UIViewController_Menu*)[segue destinationViewController];
        uivMenu->filtre = filtre;
    } else if ([[segue identifier] isEqualToString:@"sw_front"]) {
         map = (UIViewController_Map *)segue.destinationViewController;
        [map initWith:filtre];
    }
}

@end