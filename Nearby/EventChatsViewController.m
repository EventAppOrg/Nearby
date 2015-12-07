//
//  EventChatsViewController.m
//  Nearby
//
//  Created by Kavin Arasu on 12/7/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "EventChatsViewController.h"
#import "ChatPostTableViewCell.h"
#import "EventChat.h"

@interface EventChatsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *chatsTableView;
@property (strong, nonatomic) NSMutableArray *eventChats;
@property (weak, nonatomic) IBOutlet UITextField *chatTextField;

@end

@implementation EventChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(onCloseTapped)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    [self.chatsTableView registerNib:[UINib nibWithNibName:@"ChatPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatPostCell"];
    self.chatsTableView.dataSource = self;
    self.chatsTableView.delegate = self;
    self.chatsTableView.rowHeight = UITableViewAutomaticDimension;
    self.chatsTableView.estimatedRowHeight = 120;
    self.chatTextField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void) onCloseTapped {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventChats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatPostTableViewCell *cell = [self.chatsTableView dequeueReusableCellWithIdentifier:@"chatPostCell"];
    cell.eventChat = self.eventChats[indexPath.row];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) setEvent:(Event *)event {
    _event = event;
    [EventChat getEventChatsForEvent:_event completion:^(NSArray *eventChats, NSError *error) {
        if(!error) {
            self.eventChats = eventChats;
            [self.chatsTableView reloadData];
        }
    }];

}

- (void) animateTextField: (UITextField *)textField up: (BOOL) up
{
    const int movementDistance = 260; // tweak as needed
    const float movementDuration = 0.17f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Enter pressed");
    [self.chatTextField resignFirstResponder];
    NSString *chatText = [self.chatTextField text];
    if(![chatText isEqualToString:@""]) {
        self.chatTextField.text = @"";
        [EventChat createEventChatForEvent:_event forUser:[PFUser currentUser] withText:chatText completion:^(EventChat *eventChat, NSError *error) {
            if(!error) {
                NSLog(@"Chat created");
                NSMutableArray* rows = [[NSMutableArray alloc] init];
                [rows addObject:eventChat];
                [self.eventChats insertObject:eventChat atIndex:0];
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.chatsTableView beginUpdates];
                [self.chatsTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.chatsTableView endUpdates];
            }
        }];
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
