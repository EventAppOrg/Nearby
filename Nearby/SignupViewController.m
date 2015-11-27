//
//  SignupViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordRepeatTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;

@end

@implementation SignupViewController

UIAlertController *statusAlert;

- (void)viewDidLoad {
    self.title = @"Nearby";
    [self.errorMessageLabel setHidden:YES];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.usernameTextField becomeFirstResponder];
}

- (BOOL)validateEmail:(NSString *)text {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

- (IBAction)signupButtonAction:(id)sender {
    [self.errorMessageLabel setHidden:YES];
    if (![self validateEmail:self.usernameTextField.text]) {
        self.errorMessageLabel.text = @"Please specify valid email address";
        [self.errorMessageLabel setHidden:NO];
        return;
    }
    if (self.passwordTextField.text.length < 2) {
        self.errorMessageLabel.text = @"Password too short";
        [self.errorMessageLabel setHidden:NO];
        return;
    }
    if (self.passwordTextField.text != self.passwordRepeatTextField.text) {
        self.errorMessageLabel.text = @"Passwords don't match";
        [self.errorMessageLabel setHidden:NO];
        return;
    }
    
    PFUser *u = [[PFUser alloc] init];
    [u setUsername:self.usernameTextField.text];
    [u setPassword:self.passwordTextField.text];
    [u signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Signed up user!");
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle: @"Success"
                                                                                message: @"Signed up successfully"
                                                                         preferredStyle: UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Ok"
                                                                  style: UIAlertActionStyleDestructive
                                                                handler: ^(UIAlertAction *action) {
                                                                    [controller dismissViewControllerAnimated:YES completion:nil];
                                                                    [self.navigationController popViewControllerAnimated:YES];
                                                                }];
            
            [controller addAction: alertAction];
            [self presentViewController:controller animated:YES completion: nil];
        } else {
            NSLog(@"Failed: %@", error);
            self.errorMessageLabel.text = @"User already exists";
            [self.errorMessageLabel setHidden:NO];
        }
    }];
}

@end
