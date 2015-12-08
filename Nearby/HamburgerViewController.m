//
//  HamburgerViewController.m
//  Nearby
//
//  Created by Kavin Arasu on 12/7/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic) CGFloat originalLeftMargin;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setMenuViewController:(UIViewController *)menuViewController {
    _menuViewController = menuViewController;
    [self.view layoutIfNeeded];
    [self.menuView addSubview:menuViewController.view];
}

- (void) setContentViewController:(UIViewController *)contentViewController {
    NSLog(@"Setting content view ");
    
    if(_contentViewController != nil) {
        [_contentViewController willMoveToParentViewController:nil];
        [_contentViewController.view removeFromSuperview];
        [_contentViewController didMoveToParentViewController:nil];
    }
    
    _contentViewController = contentViewController;
    [self.view layoutIfNeeded];
    [_contentViewController willMoveToParentViewController:self];
    [self.contentView addSubview:contentViewController.view];
    [_contentViewController didMoveToParentViewController:self];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.4 options:0 animations:^{
        self.leftMarginConstraint.constant = 0;
    } completion:nil];
    
}

- (IBAction)onContentViewPanned:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view];
    CGPoint velocity = [sender velocityInView:sender.view];
    if(sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Began");
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Changed");
        self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Ended");
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
            if(velocity.x > 0) {
                self.leftMarginConstraint.constant = sender.view.frame.size.width - 50;
            } else {
                self.leftMarginConstraint.constant = 0;
            }
            
        } completion:nil];
    }
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
