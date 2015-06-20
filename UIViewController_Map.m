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

- (void)playingInterval:(NSTimer*) t  {
    NSLog(@"playing");
    if([((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList count] > filtre->indexInterval+1)
        filtre->indexInterval = filtre->indexInterval + 1;
    else
        filtre->indexInterval = 0;
    
    /*
     * remove all ouverlay
     */
    [mapView clear];
    
    NSLog(@"Index interval = %d", filtre->indexInterval);
    GroundOverLay *interval = [((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList objectAtIndex:filtre->indexInterval];
    NSLog(@"date start = %@", interval->timeStampBegin);
    intervalTitle.text = [Factory getFormatSelectionDateString:interval->timeStampBegin :interval->timeStampEnd];
    
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
    [sourceFile appendString:filtre->site->urlDirectory];
    [sourceFile appendString:interval->iconPath];
    
    NSLog(@"img sourceFile ==%@", sourceFile);
    
    [mapView clear];
    
    // Image
    NSString *ImageURL = [sourceFile mutableCopy];
    
    ImageURL =[ImageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    UIImage *icon = [UIImage imageWithData:data];
    
    GMSGroundOverlay *overlay =
    [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
    overlay.bearing = 0;
    overlay.map = mapView;
}

- (IBAction)play:(id)sender {
    if(!isPlaying) {
        NSLog(@"playing");
        isPlaying = true;
        [buttonPlay setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        myTimer = [NSTimer scheduledTimerWithTimeInterval: 1 target: self
                                                 selector: @selector(playingInterval:) userInfo: nil repeats: YES];
    } else {
        [self unplayWhilePlaying];
    }
}

- (id)initWith:(Filtre*)_filtre {
    if(self)
    {
        isPlaying = false;
        zoomDefault = 15;
        filtre = _filtre;
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    zoomCurrent = zoomDefault;
    NSLog(@"Index interval = %d", filtre->indexInterval);
    
    GroundOverLay *interval = [((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList objectAtIndex:filtre->indexInterval];
    
    intervalTitle.text = [Factory getFormatSelectionDateString:interval->timeStampBegin :interval->timeStampEnd];
    
    latitude = (interval->latLongNorth + interval->latLongSouth)/2;
    
    longitude = (interval->latLongEast + interval->latLongWest)/2;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:zoomDefault];
    
    mapView = [GMSMapView mapWithFrame:mapViewSB.bounds camera:camera];
    
    /*
     * Put the legend on the map
     */
    NSMutableString *sourceFile = [[NSMutableString alloc] init];
    [sourceFile appendString:filtre->site->urlDirectory];
    Pollutant *pollutantSelected = [filtre->site->myPollutants objectAtIndex:filtre->indexPollutant];
    [sourceFile appendString:pollutantSelected->screenOverLay->iconPath];
    //You need to specify the frame of the view
    UIView *catView = [[UIView alloc] initWithFrame:CGRectMake(15, 25,pollutantSelected->screenOverLay->sizeX,pollutantSelected->screenOverLay->sizeY)];
    
    NSString *ImageURL = [sourceFile mutableCopy];
    
    ImageURL =[ImageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    UIImage *icon = [UIImage imageWithData:data];
    
    icon = [UIViewController_Map processImage:icon];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:icon];
    
    //specify the frame of the imageView in the superview , here it will fill the superview
    imageView.frame = catView.bounds;
    
    // add the imageview to the superview
    [catView addSubview:imageView];
    
    //add the view to the main view
    
    [mapView addSubview:catView];
    
    /*
     * Put the image on the map
     */
    
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(interval->latLongSouth,interval->latLongWest);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(interval->latLongNorth, interval->latLongEast);
    GMSCoordinateBounds *overlayBounds = [[GMSCoordinateBounds alloc] initWithCoordinate:southWest
                                                                              coordinate:northEast];
    sourceFile = [[NSMutableString alloc] init];
    [sourceFile appendString:filtre->site->urlDirectory];
    [sourceFile appendString:interval->iconPath];
    
    ImageURL = [sourceFile mutableCopy];
    
    ImageURL =[ImageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    
    // Image
    icon = [UIImage imageWithData:data];
    
    GMSGroundOverlay *overlayPollutant =
    [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
    overlayPollutant.bearing = 0;
    overlayPollutant.map = mapView;
    
    [self->mapViewSB addSubview:mapView];
    
    self.revealViewController.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)recenterCamera:(id)sender {
    [self unplayWhilePlaying];
    // set latitude and longitude of the first interval
    // Set also the default zoom
    GroundOverLay *firstInterval = [((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList objectAtIndex:filtre->indexInterval];

    latitude = (firstInterval->latLongNorth + firstInterval->latLongSouth)/2;
    longitude = (firstInterval->latLongEast + firstInterval->latLongWest)/2;
    CLLocationCoordinate2D coordinates =  CLLocationCoordinate2DMake(latitude,longitude);
    GMSCameraUpdate *updatedCamera = [GMSCameraUpdate setTarget:coordinates zoom:zoomDefault];
    [mapView animateWithCameraUpdate:updatedCamera];

}

-(void)unplayWhilePlaying {
    if(isPlaying) {
        NSLog(@"stopped");
        isPlaying = false;
        [buttonPlay setImage:nil forState:UIControlStateNormal];
        [buttonPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [myTimer invalidate];
    }
}

- (IBAction)zoom:(id)sender {
    [self unplayWhilePlaying];
    
    if(zoomCurrent+1 <= 20) {
        zoomCurrent = zoomCurrent + 1;
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate zoomTo:zoomCurrent];
        [mapView animateWithCameraUpdate:updatedCamera];
    }
}

- (IBAction)unzoom:(id)sender {
    [self unplayWhilePlaying];
    
    if(zoomCurrent-1 >= 1) {
        zoomCurrent = zoomCurrent - 1;
        GMSCameraUpdate *updatedCamera = [GMSCameraUpdate zoomTo:zoomCurrent];
        [mapView animateWithCameraUpdate:updatedCamera];
    }
}

- (IBAction)moreInterval:(id)sender {
    [self unplayWhilePlaying];
    
    if([((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList count] > filtre->indexInterval+1) {
        filtre->indexInterval = filtre->indexInterval + 1;
        /*
         * remove all ouverlay
         */
        [mapView clear];
        
        NSLog(@"Index interval = %d", filtre->indexInterval);
        GroundOverLay *interval = [((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList objectAtIndex:filtre->indexInterval];
        NSLog(@"date start = %@", interval->timeStampBegin);
        intervalTitle.text = [Factory getFormatSelectionDateString:interval->timeStampBegin :interval->timeStampEnd];
        
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
        [sourceFile appendString:filtre->site->urlDirectory];
        [sourceFile appendString:interval->iconPath];
        [mapView clear];
        
        // Image
        NSString *ImageURL = [sourceFile mutableCopy];
        
        ImageURL =[ImageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        UIImage *icon = [UIImage imageWithData:data];
        
        GMSGroundOverlay *overlay =
        [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
        overlay.bearing = 0;
        overlay.map = mapView;
    }
}

- (IBAction)lessInterval:(id)sender {
    [self unplayWhilePlaying];
    if(filtre->indexInterval-1 >= 0) {
        filtre->indexInterval = filtre->indexInterval - 1;
        
        /*
         * remove all ouverlay
         */
        [mapView clear];
        NSLog(@"Index interval = %d", filtre->indexInterval);
        GroundOverLay *interval = [((Pollutant*)[filtre->site->modelKml->myPollutants objectAtIndex:filtre->indexPollutant])->polutionInterval->groundOverLayList objectAtIndex:filtre->indexInterval];
        NSLog(@"date start = %@", interval->timeStampBegin);
        intervalTitle.text = [Factory getFormatSelectionDateString:interval->timeStampBegin :interval->timeStampEnd];
        
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
        [sourceFile appendString:filtre->site->urlDirectory];
        [sourceFile appendString:interval->iconPath];
        [mapView clear];
        
        // Image
        NSString *ImageURL = [sourceFile mutableCopy];
        
        ImageURL =[ImageURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        UIImage *icon = [UIImage imageWithData:data];
        GMSGroundOverlay *overlay =
        [GMSGroundOverlay groundOverlayWithBounds:overlayBounds icon:icon];
        overlay.bearing = 0;
        overlay.map = mapView;
    }

}

- (IBAction)changeInterval:(id)sender {
    [self unplayWhilePlaying];
    UIViewController_Interval *viewArrayInterval = [self.storyboard instantiateViewControllerWithIdentifier:@"PickerViewDate"];
    viewArrayInterval->map = self;
    [self.navigationController pushViewController:viewArrayInterval animated:YES];
}

+ (UIImage*) processImage :(UIImage*) image
{
    const CGFloat colorMasking[6] = {255.0, 255.0, 255.0, 255.0, 255.0, 255.0};
    CGImageRef imageRef = CGImageCreateWithMaskingColors(image.CGImage, colorMasking);
    UIImage* imageB = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return imageB;
}

@end