//
//  LoginViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "LoginViewController.h"
#import "EventViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButtonAction:(id)sender {
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (user != nil) {
            NSLog(@"Logged in!");
            EventViewController *vc = [[EventViewController alloc] init];
            vc.user = user;
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:navController animated:YES completion:nil];
        } else {
            NSLog(@"Failed to log in: %@", error);
        }
    }];
}


@end
