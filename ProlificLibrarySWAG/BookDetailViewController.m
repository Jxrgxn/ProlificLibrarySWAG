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
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.bookDetailObject.lastDateCheckedOutBy == (id)[NSNull null])
    {
        self.bookDetailObject.lastDateCheckedOutBy = @"Unavailable";
    }

    self.titleLabel.text = self.bookDetailObject.title;
    self.authorLabel.text = self.bookDetailObject.author;
    self.publisherLabel.text = self.bookDetailObject.publisher;
    self.lastCheckedOutLabel.text = [NSString stringWithFormat:@"%@ at %@", self.bookDetailObject.lastDateCheckedOutBy, self.bookDetailObject.lastCheckedOutDate];}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
