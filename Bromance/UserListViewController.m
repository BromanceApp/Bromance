//  UserListViewController.m
//
//  Copyright (C) 2013 BromanceApp

#import "UserListViewController.h"
#import "User.h"
#import "UserCell.h"
#import "UserProfileViewController.h"
#import <UIImageView+AFNetworking.h>
#import "BromanceTabBarController.h"
#import "Common.h"

@interface UserListViewController ()

@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)logOutClicked:(id)sender;

@end

@implementation UserListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearData)
                                                 name:LOG_OUT_NOTIFICATION object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reload];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UserProfileViewController *profileVC = (UserProfileViewController *) segue.destinationViewController;
    profileVC.user = self.users[indexPath.row];
}

#pragma mark UITableViewDataSource methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = self.users[indexPath.row];
    UserCell *cell = (UserCell* )[self.tableView dequeueReusableCellWithIdentifier:@"UserListViewCell" forIndexPath:indexPath];
    
    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=square", user.facebookId]];
    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
    
    [cell.imageView setImageWithURLRequest:profilePictureURLRequest placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        user.profilePhoto = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    cell.imageView.image = user.profilePhoto;
    cell.nameLabel.text = user.name;
    cell.locationLabel.text = user.location;
    cell.distanceLabel.text = user.distanceFormat;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

#pragma mark Private Methods
- (void)reload
{
    [User allUsersWithCompletion:^(NSArray *users, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else if (users && users.count > 0) {
            self.users = users;
        }
        
        [self.tableView reloadData];
    }];
}

- (void)clearData {
    _users = @[];
    [self.tableView reloadData];
}

- (IBAction)logOutClicked:(id)sender {
    [PFUser logOut];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOG_OUT_NOTIFICATION object:self];
}

@end
