//
//  LoginViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/24/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "LoginViewController.h"
#import "EventViewController.h"
#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    self.title = @"Nearby";
    [self.errorMessageLabel setHidden:YES];
    
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    PFUser *u = [PFUser currentUser];
    if ([u isAuthenticated]) {
        [self showEventViewController:u];
    }
    [self.usernameTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showEventViewController:(PFUser *)user {
    EventViewController *vc = [[EventViewController alloc] init];
    vc.user = user;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)loginButtonAction:(id)sender {
    [self.errorMessageLabel setHidden:YES];
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (user != nil) {
            NSLog(@"Logged in!");
//            [self showEventViewController:user];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidLoginNotification" object:nil];
        } else {
            NSLog(@"Failed to log in: %@", error);
            self.errorMessageLabel.text = @"Incorrect email or password";
            [self.errorMessageLabel setHidden:NO];
        }
    }];
}

- (IBAction)signupButtonAction:(id)sender {
    SignupViewController *svc = [[SignupViewController alloc] init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:svc animated:YES];
}



@end
