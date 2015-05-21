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
    
    // Initialize Data
    _pickerData = @[@"Item 1", @"Item 2", @"Item 3", @"Item 4", @"Item 5", @"Item 6"];
    
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
    map->indexInterval = (int)[pickerView selectedRowInComponent:0];
    UIViewController_SW *mapView = [self.storyboard instantiateViewControllerWithIdentifier:@"SWGoogleMapView"];
    mapView->pathDirectory = map->pathDirectory;
    mapView->filtre = map->filtre;
    mapView->airModelXml = map->airModelXml;
    [self.navigationController pushViewController:mapView animated:YES];
}

@end