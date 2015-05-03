//
//  Filtre.h
//  test
//
//  Created by BOUSSAADIA AMIR on 30/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#ifndef test_Filtre_h
#define test_Filtre_h

#import "Filtre.h"

@interface Site : NSObject {
    @public
    NSString *libelle;
    NSMutableArray *myDates;
}

@property (nonatomic, retain) NSString *libelle;

@end

@interface User : NSObject {
    @public
    NSString *login, *password;
    NSMutableArray *myLocations;
}

@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSMutableArray *myLocations;
@end


@interface Filtre : NSObject {
    @public
    Site *site;
    User *user;
    NSString *date;
}
@end

#endif
