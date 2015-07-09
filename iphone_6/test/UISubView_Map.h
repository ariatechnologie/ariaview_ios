//
//  UISubView_Map.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 15/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_UISubView_Map_h
#define AriaViewIOS_UISubView_Map_h
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@class  UIViewController_Map;

@interface UISubView_Map : UIView {
    @public
    UIViewController_Map *mapSuper;
    GMSMapView *mapView;
}
-(id)initWithMap:(UIViewController_Map *)superMap;
@end

#endif
