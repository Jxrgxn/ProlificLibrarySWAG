//
//  EditBookViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/30/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "EditBookViewController.h"
#import "BookDetailViewController.h"
#import "APIConnectionHelper.h"

@interface EditBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *editAuthorTextField;
@property (weak, nonatomic) IBOutlet UITextField *editPublisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *editCategoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastCheckedOutTextField;

@end

@implementation EditBookViewController

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

    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];

    self.editTitleTextField.text = self.editBookDetailObject.title;
    self.editAuthorTextField.text = self.editBookDetailObject.author;
    self.editPublisherTextField.text = self.editBookDetailObject.publisher;
    if (!self.editBookDetailObject.lastCheckedOutDate) {
        self.lastCheckedOutTextField.text  = @"N/A!!";
    } else {
    self.lastCheckedOutTextField.text = [NSString stringWithFormat:@"%@ at %@", self.editBookDetailObject.lastDateCheckedOutBy, self.editBookDetailObject.lastCheckedOutDate];
    }

}
- (IBAction)onSaveButtonPressed:(id)sender {
    [APIConnectionHelper updateLibraryBook:self.editTitleTextField.text author:self.editAuthorTextField.text categories:self.editCategoryTextField.text publisher:self.editPublisherTextField.text bookID:self.editBookDetailObject.ID lastCheckedOutBy:self.lastCheckedOutTextField.text];

    self.editBookDetailObject.title = self.editTitleTextField.text;
    self.editBookDetailObject.author = self.editAuthorTextField.text;
    self.editBookDetailObject.publisher = self.editPublisherTextField.text;
    self.editBookDetailObject.categories = self.editCategoryTextField.text;

    self.editBookDetailObject.lastDateCheckedOutBy = self.lastCheckedOutTextField.text;
    [self.navigationController popViewControllerAnimated:true];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
