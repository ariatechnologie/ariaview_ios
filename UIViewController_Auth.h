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
#import "Filtre.h"

@interface UIViewController_Auth : UIViewController {
    NSString *path, *url, *infosXML;
    NSFileManager *ariaDirectory;
    Factory *factory;
    NSString *login, *password;
    Filtre *filtre;
    __weak IBOutlet UIButton *usButton;
    __weak IBOutlet UIButton *frButton;
    __weak IBOutlet UILabel *loginUILabel;
    __weak IBOutlet UILabel *passwordUILabel;
    __weak IBOutlet UIButton *connexionUIButton;
    __weak IBOutlet UINavigationItem *navBar;
}
- (IBAction)onClickFr:(id)sender;
- (IBAction)onClickUs:(id)sender;
- (void)awakeFromNib;
-(id)initWithFiltre:(Filtre *)filtre;
- (IBAction)onKeyLogin:(UITextField *)sender;
- (IBAction)onKeyPassword:(UITextField *)sender;
- (IBAction)onClick:(id)sender;

@end
