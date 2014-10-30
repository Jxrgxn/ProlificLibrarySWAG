//
//  BookDetailViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/24/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "BookDetailViewController.h"
#import "EditBookViewController.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckedOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkoutButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

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
    self.categoriesLabel.text = [NSString stringWithFormat:@"Tags: %@", self.bookDetailObject.categories];
    self.lastCheckedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.bookDetailObject.lastDateCheckedOutBy, self.bookDetailObject.lastCheckedOutDate];
}
- (IBAction)onCheckoutButtonPressed:(id)sender {


}

-(IBAction)onShareButtonPressed:(id)sender
{
    NSString *shareText = [NSString stringWithFormat:@"Guess who just checked out this book:\n\n%@\n%@\n%@\n%@\n%@", self.titleLabel.text, self.authorLabel.text, self.publisherLabel.text, self.categoriesLabel.text, [NSString stringWithFormat:@"Last checked out by: %@", self.lastCheckedOutLabel.text]];

    UIActivityViewController *shareVC = [[UIActivityViewController alloc]initWithActivityItems:@[shareText] applicationActivities:nil];
    [self presentViewController:shareVC animated:YES completion:^{}];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.editButton){
        EditBookViewController *editVC = segue.destinationViewController;
        editVC.editBookDetailObject = self.bookDetailObject;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
