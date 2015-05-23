//
//  UIViewController_Interval.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 20/05/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_UIViewController_Interval_h
#define AriaViewIOS_UIViewController_Interval_h

#import <UIKit/UIKit.h>
#import "UIViewController_Map.h"
#import "UIViewController_SW.h"
#import "Factory.h"

@interface UIViewController_Interval : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    NSMutableArray *_pickerData;
    __weak IBOutlet UIPickerView *pickerView;
    Factory *factory;
    @public
    UIViewController_Map *map;
}

- (IBAction)onclick:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end

#endif
