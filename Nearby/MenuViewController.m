//
//  MenuViewController.m
//  Nearby
//
//  Created by Kavin Arasu on 12/7/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "MenuViewController.h"
#import "EventViewController.h"
#import "MenuTableViewCell.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic) NSArray *iconImages;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.menuItems = @[@"Home"];
    UIViewController *viewController1 = [[EventViewController alloc] init];
    self.viewControllers = @[viewController1];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"menuCell"];
    self.menuTableView.rowHeight = UITableViewAutomaticDimension;
    self.menuTableView.estimatedRowHeight = 60;
    UIImage *image1 = [UIImage imageNamed:@"ic_home"];
    self.iconImages = @[image1];
    self.menuTableView.dataSource = self;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:@"menuCell"];
    cell.label = self.menuItems[indexPath.row];
    cell.iconImage = self.iconImages[indexPath.row];
    NSLog(@"Row is %ld", indexPath.row);
    return cell;
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
