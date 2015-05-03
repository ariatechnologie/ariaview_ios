//
//  ViewController.h
//  test
//
//  Created by BOUSSAADIA AMIR on 31/03/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController_Site.h"
#import "DownloadTaskSync.h"
#import "Factory.h"
#import "UIViewController_Error.h"

@interface ViewController : UIViewController {
    NSString *path;
    NSString *url;
    NSString *urlStub;
    NSString *loginXML;
    NSFileManager *ariaDirectory;
    Factory *factory;
    NSString *login;
    NSString *password;

}

- (IBAction)onKeyLogin:(UITextField *)sender;

- (IBAction)onKeyPassword:(UITextField *)sender;

- (IBAction)onClick:(id)sender;

@end

