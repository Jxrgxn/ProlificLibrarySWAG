//
//  BookDetailViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/24/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckedOutLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkoutButton;

@end

@implementation BookDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.checkoutButton.placeholder = @"Checkout this Book";
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.titleLabel.text = self.bookDetailObject.title;
    self.authorLabel.text = self.bookDetailObject.author;
    self.publisherLabel.text = self.bookDetailObject.publisher;
    self.lastCheckedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.bookDetailObject.lastDateCheckedOutBy, self.bookDetailObject.lastCheckedOutDate];
}
- (IBAction)onCheckoutButtonPressed:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"To Check out this Book...!" message:@"Please enter your name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextField = [alert textFieldAtIndex:0];;
    alertTextField.placeholder = @"Enter your name";
    [alert show];

    if ([alertTextField.text  isEqual: @""]){
        [alert show];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
