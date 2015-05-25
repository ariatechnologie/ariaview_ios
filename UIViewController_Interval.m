//
//  UIViewController_Interval.m
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 20/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController_Interval.h"

@implementation UIViewController_Interval


-(void) viewDidLoad {
    [super viewDidLoad];
    factory = [[Factory alloc] init];
    // Initialize Data
    if(map != nil && map->filtre != nil && map->filtre->site != nil && map->filtre->site->modelKml != nil && map->filtre->site->modelKml->myPollutants != nil &&  [map->filtre->site->modelKml->myPollutants objectAtIndex:map->filtre->indexPollutant] != nil && ((Pollutant*)[map->filtre->site->modelKml->myPollutants objectAtIndex:map->filtre->indexPollutant])->polutionInterval != nil && ((Pollutant*)[map->filtre->site->modelKml->myPollutants objectAtIndex:map->filtre->indexPollutant])->polutionInterval->groundOverLayList != nil && [((Pollutant*)[map->filtre->site->modelKml->myPollutants objectAtIndex:map->filtre->indexPollutant])->polutionInterval->groundOverLayList count] > 0) {
        PolutionInterval *polutioninterval = ((Pollutant*)[map->filtre->site->modelKml->myPollutants objectAtIndex:map->filtre->indexPollutant])->polutionInterval;
        NSLog(@"number of interval =%lu", (unsigned long)[polutioninterval->groundOverLayList count]);
        _pickerData = [[NSMutableArray alloc] init];
        NSLog(@"begin insert into table pickerDate");
        for (int i = 0; i < [polutioninterval->groundOverLayList count]; i++) {
            GroundOverLay *gol = [polutioninterval->groundOverLayList objectAtIndex:i];
            if(gol != nil || gol->timeStampBegin != nil || gol->timeStampEnd != nil) {
                NSString *labelInterval = [Factory getFormatSelectionDateString:gol->timeStampBegin :gol->timeStampEnd ];
                if(labelInterval != nil)
                    [_pickerData addObject:labelInterval];
            }
        }
    } else {
        NSLog(@"no data");
    }
    // Connect data
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (IBAction)onclick:(id)sender {
    /*
     * Connexion is Ok, then reload map and polution sky
     */
    if([Factory getConnectionState ]) {
        int indexInterval = (int)[pickerView selectedRowInComponent:0];
        UIViewController_SW *mapView = [[self.storyboard instantiateViewControllerWithIdentifier:@"SWGoogleMapView"] initWithFiltre:map->filtre];
        [self.navigationController pushViewController:mapView animated:YES];
    } else {
        [Factory alertMessage:factory->titleConnextionError:factory->messageConnextionError:self];
    }
}

@end