//
//  BookDetailViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/24/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "BookDetailViewController.h"
#import "EditBookViewController.h"
#import "APIConnectionHelper.h"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckedOutLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation BookDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self putBookInfo];
}

// HERE WHAT YOU SHOULD DO WHEN THE VIEW IS PRESENTENED AFTER EDITING A BOOK WHICH METHOD IS CALLED

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self putBookInfo];
    self.lastCheckedOutLabel.adjustsFontSizeToFitWidth = YES;
}

-(void)putBookInfo
{
    if (self.bookDetailObject.categories == (id)[NSNull null]) {
        self.categoriesLabel.text = @"";
    }
    self.titleLabel.text = self.bookDetailObject.title;
    self.authorLabel.text = self.bookDetailObject.author;
    self.publisherLabel.text = self.bookDetailObject.publisher;
    self.categoriesLabel.text = [NSString stringWithFormat:@"Tags: %@", self.bookDetailObject.categories];
    self.lastCheckedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.bookDetailObject.lastDateCheckedOutBy, self.bookDetailObject.lastCheckedOutDate];
    
}

- (IBAction)onCheckoutButtonPressed:(id)sender {
    UIAlertView *alertView = [UIAlertView new];
    [alertView setDelegate:self];
    [alertView setTitle:@"Please Enter Your Name"];
    [alertView addButtonWithTitle:@"Cancel"];
    [alertView addButtonWithTitle:@"OK"];

    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeAlphabet;

    [alertView show];

    NSDate *currentDate = [NSDate date];

    [APIConnectionHelper checkedOutBook:self.bookDetailObject.lastDateCheckedOutBy author:self.bookDetailObject.author bookID:self.bookDetailObject.ID checkedOutDate:currentDate];

    self.bookDetailObject.lastCheckedOutDate = currentDate;

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *name = [alertView textFieldAtIndex:0].text;
        self.bookDetailObject.lastDateCheckedOutBy = name;
    }
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
