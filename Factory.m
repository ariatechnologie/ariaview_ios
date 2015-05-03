//
//  Factory.m
//  test
//
//  Created by BOUSSAADIA AMIR on 28/04/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Factory.h"
#import "Reachability.h"

@implementation Factory

-(id) init
{
    self = [super init];
    if(self)
    {
        messageConnextionError = @"Connexion internet non fonctionnelle, vérifier votre connexion.";
        titleConnextionError = @"Etat connexion";
        messageAuthError = @"Les identifiants saisis sont incorrectes.";
        titleAuthError = @"Authentification";
        messageWebServiceDownError = @"Impossible d'atteindre le serveur, veuillez réessayer ultérieurement.";
        titleWebServiceDownError = @"Web service";
        messageTechnicalError = @"Une erreur technique est survenue, veuillez réessayer ultérieurement.";
        titleTechnicalError = @"Web service";
        messageNoSiteError = @"Il n'existe pas de site repertorié pour votre compte.";
        titleNoSiteError = @"Avertissement";
        messageNoDateError = @"Il n'existe pas d'historisation de poluant pour ce site.";
        titleNoDateError = @"Avertissement";

    }
    return self;
}

+ (BOOL) getConnectionState {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return false;
    } else {
        return true;
    }
}

+ (void) alertMessage : (NSString*) title : (NSString*) message : (UIViewController*) delegate {
    //  init view and set text error
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: title
                                                   message: message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [alert setTag:1];
    [alert show];
}
@end