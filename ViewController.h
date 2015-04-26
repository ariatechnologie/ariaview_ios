//
//  ViewController.h
//  test
//
//  Created by BOUSSAADIA AMIR on 31/03/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController_Site.h"

@interface ViewController : UIViewController {
    NSString *path;
    NSString *url;
    NSString *urlBouchon;
    NSString *loginXML;
    NSFileManager *ariaDirectory;
    
    NSString *login;
    NSString *password;

}

- (IBAction)onKeyLogin:(UITextField *)sender;

- (IBAction)onKeyPassword:(UITextField *)sender;

- (IBAction)onClick:(id)sender;

@end

