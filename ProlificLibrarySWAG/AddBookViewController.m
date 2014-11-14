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
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onSubmitButtonPressed:(id)sender {
    if ([self.bookTitleTextField.text isEqualToString:@""] || [self.authorTextField.text isEqualToString:@""]){
        UIAlertView *emptySubmitAlert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You have to enter a Title and Author" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

        [emptySubmitAlert show];
    }else{
        [APIConnectionHelper addLibraryBook:self.bookTitleTextField.text author:self.authorTextField.text categories:self.categoriesTextField.text publisher:self.publisherTextField.text];
//Notes for the coder--So as it stands now the code will just execute and confirm that the user has sent their information but at this point it just does it like some dummy app. So you need to add a completion block that only resets the text when there's actually a success in the networking transmission. 
//        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//
//            UIAlertView *submissionAlert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"You just added a new book!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//            [submissionAlert show];
//        }];

    self.bookTitleTextField.text = @"";
    self.authorTextField.text = @"";
    self.categoriesTextField.text = @"";
    self.publisherTextField.text = @"";

    UIAlertView *submissionAlert = [[UIAlertView alloc]initWithTitle:@"Success!" message:@"You just added a new book!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [submissionAlert show];


    }
}

- (IBAction)onDoneButtonTapped:(id)sender {
    if (![self.bookTitleTextField.text isEqualToString:@""] || ![self.authorTextField.text isEqualToString:@""]){ 

        self.emptyDoneAlert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Your changes won't be saved if you leave this page." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        self.emptyDoneAlert.tag = 0;
        [self.emptyDoneAlert show];

    }else
        [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (alertView.tag == 0 && buttonIndex == 1)
    {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}


@end
