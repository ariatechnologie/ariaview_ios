//
//  UIViewController_Graph.h
//  AriaViewIOS
//
//  Created by BOUSSAADIA AMIR on 02/07/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef AriaViewIOS_UIViewController_Graph_h
#define AriaViewIOS_UIViewController_Graph_h

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"
#import "Filtre.h"
#import "Coordinate.h"
#import "Factory.h"

@interface UIViewController_Graph : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate> {
    Filtre *filtre;
    Factory *factory;
}

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;

@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;

@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;

- (id) initWith:(Filtre*) _filtre;

@end

#endif
