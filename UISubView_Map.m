//
//  UISubView_Map.m
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 15/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "UISubView_Map.h"
#import "UIViewController_Map.h"

@interface UISubView_Map ()

@end

@implementation UISubView_Map

-(id)initWithMap:(UIViewController_Map *)superMap
{
    self = [super init];
    if (self) {
        self->mapSuper = [superMap copy];
    }
    return self;
}

- (void)viewDidLoad {
    GroundOverLay *firstInterval = [mapSuper->airModelXml->polutionInterval->groundOverLayList objectAtIndex:0];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:(firstInterval->latLongNorth + firstInterval->latLongSouth)/2
                                                            longitude:(firstInterval->latLongEast + firstInterval->latLongWest)/2
                                                                 zoom:15];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    //    GMSMarker *marker = [[GMSMarker alloc] init];
    //    marker.position = camera.target;
    //    marker.snippet = filtre->site->libelle;
    //    marker.appearAnimation = kGMSMarkerAnimationPop;
    //    marker.map = mapView;
    /*
     * Put the image on the map
     */
    NSLog(@"north=%f", firstInterval->latLongNorth);
    NSLog(@"south=%f", firstInterval->latLongSouth);
    NSLog(@"east=%f", firstInterval->latLongEast);
    NSLog(@"west=%f", firstInterval->latLongWest);
    
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(firstInterval->latLongSouth,firstInterval->latLongWest);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(firstInterval->latLongNorth, firstInterval->latLongEast);
    GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                              coordinate:northEast];
    NSMutableString *sourceFile = [[NSMutableString alloc] init];
    [sourceFile appendString:mapSuper->pathDirectory];
    [sourceFile appendString:firstInterval->iconPath];
    // Image
    UIImage *icon = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:sourceFile]]];
    GMSGroundOverlay *overlay =
    [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
    overlay.bearing = 0;
    overlay.map = mapView;
    
}

@end

