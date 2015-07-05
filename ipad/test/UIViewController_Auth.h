//
//  ViewController.h
//  test
//
//  Created by BOUSSAADIA AMIR on 31/03/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadTaskSync.h"
#import "Factory.h"
#import "UIViewController_Error.h"
#import "Filtre.h"
#import "MBProgressHUD.h"

@class UIViewController_Site;
@interface UIViewController_Auth : UIViewController {
    NSString *path, *url, *infosXML;
    NSFileManager *ariaDirectory;
    Factory *factory;
    NSString *login, *password;
    Filtre *filtre;
    UIViewController_Site *viewArraySite;
    NSInteger responseCode;
    __weak IBOutlet UIButton *usButton;
    __weak IBOutlet UIButton *frButton;
    __weak IBOutlet UILabel *loginUILabel;
    __weak IBOutlet UILabel *passwordUILabel;
    __weak IBOutlet UIButton *connexionUIButton;
    __weak IBOutlet UINavigationItem *navBar;
    __weak IBOutlet UISwitch *UISwitchRemember;
    __weak IBOutlet UILabel *textSwitchRemember;
    __weak IBOutlet UITextField *UITextFieldLogin;
    __weak IBOutlet UITextField *UITextFieldPassword;
}
- (IBAction)onClickCh:(id)sender;
- (IBAction)onClickPt:(id)sender;
- (IBAction)onClickEs:(id)sender;
- (IBAction)onClickFr:(id)sender;
- (IBAction)onClickUs:(id)sender;
-(id)initWithFiltre:(Filtre *)filtre;
- (IBAction)onKeyLogin:(UITextField *)sender;
- (IBAction)onKeyPassword:(UITextField *)sender;
- (IBAction)onClick:(id)sender;

@end

