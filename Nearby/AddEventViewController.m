//
//  AddEventViewController.m
//  Nearby
//
//  Created by Piotr Czubak on 11/26/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "AddEventViewController.h"
#import "Event.h"
#import <Parse/Parse.h>

@interface AddEventViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UISwitch *privateSwitch;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *inviteUserTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) NSMutableSet *invitees;

@end

@implementation AddEventViewController

UITextField *activeField;

- (void)viewDidLoad {
    self.title = @"Nearby";
    [self.errorLabel setHidden:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Event" style:UIBarButtonItemStyleDone target:self action:@selector(addEvent)];
    [self registerForKeyboardNotifications];
    self.invitees = [NSMutableSet set];
    [self.eventNameTextField becomeFirstResponder];
    
    [super viewDidLoad];
}

- (void)addEvent {
    // TODO: add relation between self and event as going
    // TODO: add image
    // TODO: add invitees
    Event *newEvent = [[Event alloc] init];
    if ([self.eventNameTextField.text isEqualToString:@""]) {
        return;
    }
    [newEvent setOwner:[PFUser currentUser]];
    [newEvent setEventName:self.eventNameTextField.text];
    [newEvent setAddress:self.addressTextField.text];
    [newEvent setCategory:self.categoryTextField.text];
    [newEvent setDescription:self.descriptionTextField.text];
    [newEvent setIsPrivate:[NSNumber numberWithBool:self.privateSwitch.isOn]];
    [newEvent setEventDate:[self.datePicker date]];
    [newEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Saved event!");
            // TODO: show event details
        } else {
            NSLog(@"Failed: %@", error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 8, 0.0, kbRect.size.height - 20, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (IBAction)inviteUserAction:(id)sender {
    [self.errorLabel setHidden:YES];
    if (self.inviteUserTextField.text == [[PFUser currentUser] username]) {
        self.errorLabel.text = @"Can't invite yourself";
        [self.errorLabel setHidden:NO];
        return;
    }
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:self.inviteUserTextField.text];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object != nil) {
            NSLog(@"User exist: %@", object);
            [self.invitees addObject:object];
            NSLog(@"Invitees: %@", self.invitees);
        } else {
            NSLog(@"User does not exist");
            self.errorLabel.text = @"User does not exist";
            [self.errorLabel setHidden:NO];
            NSLog(@"Invitees: %@", self.invitees);
        }
    }];
}

@end
