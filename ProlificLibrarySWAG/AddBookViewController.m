//
//  AddBookViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/29/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "AddBookViewController.h"
#import "APIConnectionHelper.h"
#import "MainViewController.h"


@interface AddBookViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bookTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoriesTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) NSMutableArray *addBookMutableArray;
@property (nonatomic) UIAlertView *emptyDoneAlert;

@end

@implementation AddBookViewController

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onSubmitButtonPressed:(id)sender {
    if ([self.bookTitleTextField.text isEqualToString:@""] || [self.authorTextField.text isEqualToString:@""]){
        UIAlertView *emptySubmitAlert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You have to enter something!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

        [emptySubmitAlert show];
    }else{
    APIConnectionHelper *submitBook = [APIConnectionHelper new];
    [submitBook addLibraryBook:self.bookTitleTextField.text author:self.authorTextField.text categories:self.categoriesTextField.text publisher:self.publisherTextField.text];

    NSLog(@"Sent contents of submitBook %@", submitBook);

    self.bookTitleTextField.text = @"";
    self.authorTextField.text = @"";
    self.categoriesTextField.text = @"";
    self.publisherTextField.text = @"";
    }
}


- (IBAction)onDoneButtonTapped:(id)sender {
    if (![self.bookTitleTextField.text isEqualToString:@""] || ![self.authorTextField.text isEqualToString:@""]){

        self.emptyDoneAlert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Your changes won't be saved if you leave this page." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        self.emptyDoneAlert.tag = 0;
        self.emptyDoneAlert.delegate = self;
        [self.emptyDoneAlert show];

    }else
        [self dismissViewControllerAnimated:YES completion:^{}];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
