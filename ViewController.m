//
//  ViewController.m
//  test
//
//  Created by BOUSSAADIA AMIR on 31/03/2015.
//  Copyright (c) 2015 BOUSSAADIA AMIR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    factory = [[Factory alloc] init];
    path = @"/tmp/ariaview/";
    urlStub = @"https://raw.githubusercontent.com/ariatechnologie/ariaview_android/master/testFile/login.xml";
    url = @"http://web.aria.fr/webservices/ARIAVIEW/login.php";
    infosXML = @"infos.xml";
     
    // Hide previous button
    self.navigationItem.hidesBackButton = YES;
    
    ariaDirectory = [NSFileManager defaultManager];
    
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
    //    [path_to_log appendString:@"/"];
    //    [path_to_log appendString:loginXML];
        NSLog(@"Connecting to %@", path_to_log);
        NSMutableString *path_to_storage = [[NSMutableString alloc] init];
        [path_to_storage appendString:path];
        [path_to_storage appendString:infosXML];
        NSLog(@"path_to_storage in %@", path_to_storage);
        
    //  Download the xml content, to get sites from account(login/password)
      NSInteger responseCode = [downloadTask executeRequest:path_to_log :login:password:path_to_storage];
//      [downloadTask executeRequest:path_to_log :path_to_storage];
        
        if(responseCode == 200) {
            //  Init view and set data in table
            UIViewController_Site *viewArraySite = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewSite"];
            
            // Build filtre instance and set in the new view
            User *user = [[User alloc] init];
            user->login = login;
            user->password = password;
            Filtre *filtre = [[Filtre alloc] init];
            filtre->user = user;
            viewArraySite->filtre = filtre;
            
            [viewArraySite createLocations:downloadTask->responseData];
            [self.navigationController pushViewController:viewArraySite animated:YES];
        } else if(responseCode == 401 || responseCode == 403 || responseCode == 0) {
            [Factory alertMessage:factory->titleAuthError:factory->messageAuthError:self];
        } else {
            [Factory alertMessage:factory->titleTechnicalError:factory->messageTechnicalError:self];
        }
    } else {
       [Factory alertMessage:factory->titleConnextionError:factory->messageConnextionError:self];
    }
}
@end
