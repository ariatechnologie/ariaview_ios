//
//  ViewController.m
//  test
//
//  Created by BOUSSAADIA AMIR on 31/03/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "UIViewController_Auth.h"

@interface UIViewController_Auth ()

@end

@implementation UIViewController_Auth

- (IBAction)onClickPt:(id)sender {
    filtre->indexLanguage = 3;
    
    //  Init view and set data in table
    UIViewController_Auth *viewAuth = [[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"] initWithFiltre:filtre];
    
    [self.navigationController pushViewController:viewAuth animated:YES];
}

- (IBAction)onClickEs:(id)sender {
    filtre->indexLanguage = 2;
    
    //  Init view and set data in table
    UIViewController_Auth *viewAuth = [[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"] initWithFiltre:filtre];
    
    [self.navigationController pushViewController:viewAuth animated:YES];
}

- (IBAction)onClickFr:(id)sender {
    filtre->indexLanguage = 0; // by default, language is french

    //  Init view and set data in table
    UIViewController_Auth *viewAuth = [[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"] initWithFiltre:filtre];
    
    [self.navigationController pushViewController:viewAuth animated:YES];
}

- (IBAction)onClickUs:(id)sender {
    filtre->indexLanguage = 1;
    
    //  Init view and set data in table
    UIViewController_Auth *viewAuth = [[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"] initWithFiltre:filtre];
    
    [self.navigationController pushViewController:viewAuth animated:YES];
}

-(id)initWithFiltre:(Filtre *)_filtre
{
    if (self) {
        filtre = _filtre;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (filtre == nil) {
        filtre = [[Filtre alloc] init];
        filtre->indexLanguage = 0; // by default, language is french
    }
    factory = [[Factory alloc] initWithLanguage:filtre->indexLanguage];
    path = @"/tmp/ariaview/";
    url = @"http://web.aria.fr/webservices/ARIAVIEW/login.php";
    infosXML = @"infos.xml";
    
    navBar.title = factory->titleHeaderAuthent;
    [loginUILabel setText:factory->loginLabelText];
    [passwordUILabel setText:factory->passwordLabelText];
    [connexionUIButton setTitle:factory->connexionButtonText forState:UIControlStateNormal];
    
    // Hide previous button
    self.navigationItem.hidesBackButton = YES;
    
    ariaDirectory = [NSFileManager defaultManager];
    
    /*
     * create directory where http files will be stored
     */
    if ([ariaDirectory fileExistsAtPath: path ] == YES)
        NSLog (@"Directory exists");
    else {
        if(![ariaDirectory createDirectoryAtURL:[NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] withIntermediateDirectories:false attributes:nil error:nil])
            NSLog(@"Error: Create folder failed %@", ariaDirectory);
        else
             NSLog(@"Directory created");
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onKeyLogin:(UITextField *)sender {
     login = sender.text;
}

- (IBAction)onKeyPassword:(UITextField *)sender {
     password = sender.text;
}

- (IBAction)onClick:(id)sender {
    if([Factory getConnectionState ]) {
        DownloadTaskSync *downloadTask = [[DownloadTaskSync alloc] init];
        NSMutableString *path_to_log = [[NSMutableString alloc] init];
        [path_to_log appendString:url];
        NSLog(@"Connecting to %@", path_to_log);
        NSMutableString *path_to_storage = [[NSMutableString alloc] init];
        [path_to_storage appendString:path];
        [path_to_storage appendString:infosXML];
        NSLog(@"path_to_storage in %@", path_to_storage);
        
    //  Download the xml content, to get sites from account(login/password)
      NSInteger responseCode = [downloadTask executeRequest:path_to_log :login:password:path_to_storage];
        
        if(responseCode == 200) {
            // Build filtre instance and set in the new view
            User *user = [[User alloc] init];
            user->login = login;
            user->password = password;

            filtre->user = user;
            
            //  Init view and set data in table
            UIViewController_Site *viewArraySite = [[self.storyboard instantiateViewControllerWithIdentifier:@"TableViewSite"] initWithFiltre:filtre:true];
            [viewArraySite createLocations:downloadTask->responseData];
            
            NSLog(@"%@", self.navigationController);
            
            [self.navigationController pushViewController:viewArraySite animated:YES];
            
        } else if(responseCode == 401 || responseCode == 403 || responseCode == 0) {
            [Factory alertMessage:factory->titleAuthError:factory->messageAuthError:self];
        } else {
            [Factory alertMessage:factory->titleTechnicalError:factory->messageTechnicalError:self];
        }
    } else {
       [Factory alertMessage:factory->titleConnexionError:factory->messageConnexionError:self];
    }
}
@end
