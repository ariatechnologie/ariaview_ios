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

@interface UIViewController_Map : UIViewController<SWRevealViewControllerDelegate>  {
    __weak IBOutlet UILabel *intervalTitle;
    __weak IBOutlet UIButton *buttonPlay;
    BOOL isPlaying;
    NSTimer* myTimer;
    @public
    Filtre *filtre;
    AirModelXml *airModelXml;
    NSMutableString *pathDirectory;
    GMSMapView *mapView;
    int zoomDefault, zoomCurrent, indexInterval;
    __weak IBOutlet UIView *mapViewSB;
    double latitude, longitude;
    __weak IBOutlet UIPickerView *pickerView;
}
- (IBAction)play:(id)sender;
- (id)initWithIndexInterval:(int) _index;
- (IBAction)recenterCamera:(id)sender;
- (IBAction)zoom:(id)sender;
- (IBAction)unzoom:(id)sender;
- (void)playingInterval:(NSTimer*) t;
- (IBAction)moreInterval:(id)sender;
- (IBAction)lessInterval:(id)sender;
- (IBAction)changeInterval:(id)sender;
@end

#endif
