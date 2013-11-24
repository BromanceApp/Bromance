//  UserOptionsViewController.m
//
//  Copyright (C) 2013 BromanceApp

#import "UserOptionsViewController.h"

@interface UserOptionsViewController ()
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation UserOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.cancelButton.backgroundColor = [UIColor whiteColor];
    self.cancelButton.layer.cornerRadius = 8.0f;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

