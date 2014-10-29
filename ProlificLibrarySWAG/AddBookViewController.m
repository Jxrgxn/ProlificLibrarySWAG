//
//  AddBookViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/29/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "AddBookViewController.h"
#import "APIConnectionHelper.h"


@interface AddBookViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bookTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoriesTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) NSMutableArray *addBookMutableArray;

@end

@implementation AddBookViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSubmitButtonPressed:(id)sender {
//    if ([self.bookTitleTextField.text isEqualToString:@""] || [self.authorTextField.text isEqualToString:@""]){
//        UIAlertView *emptySubmitAlert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"You have to enter something!" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//
//        [emptySubmitAlert show];
//    }

    APIConnectionHelper *submitBook = [APIConnectionHelper new];
    [submitBook addLibraryBook:self.bookTitleTextField.text author:self.authorTextField.text categories:self.categoriesTextField.text publisher:self.publisherTextField.text];
    NSLog(@"Sent contents of submitBook %@", submitBook);
    
}

- (BOOL)textFieldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
