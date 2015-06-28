//
//  Filtre.h
//  test
//
//  Created by BOUSSAADIA AMIR on 30/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_Filtre_h
#define test_Filtre_h

#import "AirModelXml.h"

@interface Site : NSObject {
    @public
    NSString *libelle;
    NSMutableArray *myDates;
    NSMutableArray *myPollutants;
    NSString *urlDirectory;
    NSMutableArray *markers;
    AirModelXml *modelKml;
}

@property (nonatomic, retain) NSString *libelle;

@end

@interface User : NSObject {
    @public
    NSString *login, *password;
}

@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSMutableArray *myLocations;
@end


@interface Filtre : NSObject {
    @public
    BOOL pastScreen;
    Site *site;
    User *user;
    NSMutableArray *myLocations;
    NSString *date;
    NSString *pollutant;
    int indexPollutant, indexInterval, indexSite, indexLanguage;
}
@end

#endif
