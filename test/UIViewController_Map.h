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
#import "AirModelXml.h"
#import "UISubView_Map.h"
#import "UIViewController_Interval.h"
#import "Factory.h"
#import "BEMSimpleLineGraphView.h"
#import "UIViewController_Graph.h"

@interface UIViewController_Map : UIViewController<SWRevealViewControllerDelegate, GMSMapViewDelegate>  {
    __weak IBOutlet UILabel *intervalTitle;
    __weak IBOutlet UIButton *buttonPlay;
    BOOL isPlaying;
    NSTimer* myTimer;
    Factory *factory;
    NSInteger error;
    
    UIViewController_Graph *viewGraph;
    
    @public
    
    __weak IBOutlet UIView *mapViewSB;
    __weak IBOutlet UIButton *buttonMarker;
    __weak IBOutlet UIPickerView *pickerView;
    
    Filtre *filtre;
    GMSMapView *mapView;
    int zoomDefault, zoomCurrent;
    double latitude, longitude;
    BOOL isMarkerActive;
    int maxMarkers;
    GMSGroundOverlay *overlay;
    GMSCoordinateBounds *overlayBounds;
    
}
- (void) reloadView;
- (void) changeIconMarkers:(BOOL)isActive;
- (IBAction)cleanMarkers:(id)sender;
- (IBAction)onClickGraph:(id)sender;
- (IBAction)onClickMarker:(id)sender;
- (id)initWith:(Filtre*)_filtre;
- (IBAction)play:(id)sender;
- (IBAction)recenterCamera:(id)sender;
- (IBAction)zoom:(id)sender;
- (IBAction)unzoom:(id)sender;
- (void)playingInterval:(NSTimer*) t;
- (void)unplayWhilePlaying;
- (IBAction)moreInterval:(id)sender;
- (IBAction)lessInterval:(id)sender;
- (IBAction)changeInterval:(id)sender;
+ (UIImage*) processImage :(UIImage*) image;
@end

#endif
