//
//  UIViewController_Error.m
//  test
//
//  Created by BOUSSAADIA AMIR on 28/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "UIViewController_Map.h"

@interface UIViewController_Map ()
@end

@implementation UIViewController_Map

- (void) viewDidLoad {
    [super viewDidLoad];
    indexInterval = 0;
    zoomDefault = 15;
    zoomCurrent = zoomDefault;
    GroundOverLay *firstInterval = [self->airModelXml->polutionInterval->groundOverLayList objectAtIndex:indexInterval];
    
//    NSDate *dateStart, *dateEnd;
//    dateStart = firstInterval->timeStampBegin;
//    dateEnd = firstInterval->timeStampEnd;
//
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateStart];
//    NSInteger hourStart = [components hour];
//    NSInteger minuteStart = [components minute];
//    components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateEnd];
//    NSInteger hourEnd = [components hour];
//    NSInteger minuteEnd = [components minute];
//    
//    NSString *label = [NSString stringWithFormat:@"%ld H %ld - %ld H %ld", hourStart, minuteStart, hourEnd, minuteEnd];
    
    latitude = (firstInterval->latLongNorth + firstInterval->latLongSouth)/2;
    
    longitude = (firstInterval->latLongEast + firstInterval->latLongWest)/2;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:zoomDefault];
    
    mapView = [GMSMapView mapWithFrame:mapViewSB.bounds camera:camera];
    
    /*
     * Put the image on the map
     */
    
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(firstInterval->latLongSouth,firstInterval->latLongWest);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(firstInterval->latLongNorth, firstInterval->latLongEast);
    GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                              coordinate:northEast];
    NSMutableString *sourceFile = [[NSMutableString alloc] init];
    [sourceFile appendString:pathDirectory];
    [sourceFile appendString:firstInterval->iconPath];
    // Image
    UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:sourceFile]]];
    GMSGroundOverlay *overlay =
    [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
    overlay.bearing = 0;
    overlay.map = mapView;
    
    [self->mapViewSB addSubview:mapView];
    
    self.revealViewController.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)recenterCamera:(id)sender {
    // set latitude and longitude of the first interval
    // Set also the default zoom
    GroundOverLay *firstInterval = [self->airModelXml->polutionInterval->groundOverLayList objectAtIndex:indexInterval];
    latitude = (firstInterval->latLongNorth + firstInterval->latLongSouth)/2;
    longitude = (firstInterval->latLongEast + firstInterval->latLongWest)/2;
    CLLocationCoordinate2D coordinates =  CLLocationCoordinate2DMake(latitude,longitude);
    GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:coordinates zoom:zoomDefault];
    [mapView animateWithCameraUpdate:updatedCamera];

}

- (IBAction)zoom:(id)sender {
    if(zoomCurrent+1 <= 20) {
        zoomCurrent = zoomCurrent + 1;
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate zoomTo:zoomCurrent];
        [mapView animateWithCameraUpdate:updatedCamera];
    }
}

- (IBAction)unzoom:(id)sender {
    if(zoomCurrent-1 >= 1) {
        zoomCurrent = zoomCurrent - 1;
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate zoomTo:zoomCurrent];
        [mapView animateWithCameraUpdate:updatedCamera];
    }
}

- (IBAction)moreInterval:(id)sender {
    if([self->airModelXml->polutionInterval->groundOverLayList count] > indexInterval+1) {
        indexInterval = indexInterval + 1;
        /*
         * remove all ouverlay
         */
        [mapView clear];
        
        GroundOverLay *interval = [self->airModelXml->polutionInterval->groundOverLayList objectAtIndex:indexInterval];
        
        //    NSDate *dateStart, *dateEnd;
        //    dateStart = interval->timeStampBegin;
        //    dateEnd = interval->timeStampEnd;
        //
        //    NSCalendar *calendar = [NSCalendar currentCalendar];
        //    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateStart];
        //    NSInteger hourStart = [components hour];
        //    NSInteger minuteStart = [components minute];
        //    components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateEnd];
        //    NSInteger hourEnd = [components hour];
        //    NSInteger minuteEnd = [components minute];
        //
        //    NSString *label = [NSString stringWithFormat:@"%ld H %ld - %ld H %ld", hourStart, minuteStart, hourEnd, minuteEnd];
        
        /*
         * Put the image on the map
         */
        
        CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(interval->latLongSouth,interval->latLongWest);
        CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(interval->latLongNorth, interval->latLongEast);
        GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                                  coordinate:northEast];
//        /*
//         *  Set new position of the camera
//         */
//        CLLocationCoordinate2D coordinates =  CLLocationCoordinate2DMake(latitude,longitude);
//        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:coordinates zoom:zoomDefault];
//        [mapView animateWithCameraUpdate:updatedCamera];
        NSMutableString *sourceFile = [[NSMutableString alloc] init];
        [sourceFile appendString:pathDirectory];
        [sourceFile appendString:interval->iconPath];
        // Image
        UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:sourceFile]]];
        GMSGroundOverlay *overlay =
        [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
        overlay.bearing = 0;
        overlay.map = mapView;
    }
}

- (IBAction)lessInterval:(id)sender {
    if(indexInterval-1 >= 0) {
        indexInterval = indexInterval - 1;
        
        /*
         * remove all ouverlay
         */
        [mapView clear];
        
        GroundOverLay *interval = [self->airModelXml->polutionInterval->groundOverLayList objectAtIndex:indexInterval];
        
        //    NSDate *dateStart, *dateEnd;
        //    dateStart = interval->timeStampBegin;
        //    dateEnd = interval->timeStampEnd;
        //
        //    NSCalendar *calendar = [NSCalendar currentCalendar];
        //    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateStart];
        //    NSInteger hourStart = [components hour];
        //    NSInteger minuteStart = [components minute];
        //    components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:dateEnd];
        //    NSInteger hourEnd = [components hour];
        //    NSInteger minuteEnd = [components minute];
        //
        //    NSString *label = [NSString stringWithFormat:@"%ld H %ld - %ld H %ld", hourStart, minuteStart, hourEnd, minuteEnd];
        
        /*
         * Put the image on the map
         */
        
        CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(interval->latLongSouth,interval->latLongWest);
        CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(interval->latLongNorth, interval->latLongEast);
        GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                                  coordinate:northEast];
//        /*
//         *  Set new position of the camera
//         */
//        CLLocationCoordinate2D coordinates =  CLLocationCoordinate2DMake(latitude,longitude);
//        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:coordinates zoom:zoomDefault];
//        [mapView animateWithCameraUpdate:updatedCamera];
        NSMutableString *sourceFile = [[NSMutableString alloc] init];
        [sourceFile appendString:pathDirectory];
        [sourceFile appendString:interval->iconPath];
        // Image
        UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:sourceFile]]];
        GMSGroundOverlay *overlay =
        [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
        overlay.bearing = 0;
        overlay.map = mapView;
    }

}

- (IBAction)changeInterval:(id)sender {
    UIViewController_Interval *viewArrayInterval = [self.storyboard instantiateViewControllerWithIdentifier:@"PickerViewDate"];
    viewArrayInterval->map = self;
//    NSArray *dates[[airModelXml->polutionInterval->groundOverLayList count]];
//    for(int i = 0; i < [airModelXml->polutionInterval->groundOverLayList count];i++) {
//        int timeBegin =
//        dates[i] = ((GroundOverLay*) airModelXml->polutionInterval->groundOverLayList[i])->timeStampBegin;
//    }
    [self.navigationController pushViewController:viewArrayInterval animated:YES];
}

@end