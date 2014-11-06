//
//  ViewController.m
//  ProlificLibrarySWAG
//
//  Created by Basel Farag on 10/24/14.
//  Copyright (c) 2014 ABaselNotBasilProduction. All rights reserved.
//

#import "MainViewController.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "BookData.h"
#import "BookDetailViewController.h"
#import "AddBookViewController.h"
#import "APIConnectionHelper.h"


@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
@property (strong, nonatomic) NSMutableArray *allBooksArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBookBarButton;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allBooksArray = [NSMutableArray new];

    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    //get all books


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllBooks];
    [self.bookTableView reloadData];
}

-(void)getAllBooks
{
    [APIConnectionHelper getAllBooksListWithSuccess:^(NSArray *books) {
        NSLog(@"Succes");
        self.allBooksArray = [NSMutableArray arrayWithArray:books];
        [self.bookTableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Library"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Enter here!");
    //static NSString *cellIdentifier = @"cellRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRowID"];
    BookData *tempBook = [self.allBooksArray objectAtIndex:indexPath.row];
    NSLog(@"Array at this point: %@", self.allBooksArray);
    cell.textLabel.text = tempBook.title;
    cell.detailTextLabel.text = tempBook.author;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allBooksArray.count;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookData *deleteSingleBookInstance = [self.allBooksArray objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [APIConnectionHelper deleteSingleBook:deleteSingleBookInstance.ID];
        [self.bookTableView reloadData];
    }
}

#pragma Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Where are we going?
    if (sender != self.addBookBarButton){
    BookDetailViewController *detailvc = segue.destinationViewController;
    NSIndexPath *detailPath = [self.bookTableView indexPathForSelectedRow];
    detailvc.bookDetailObject = self.allBooksArray[detailPath.row];
    }

}

-(IBAction)onClearAllButtonPressed:(id)sender{
    [APIConnectionHelper deleteAll];
    [self.bookTableView reloadData];
}


//if ([allGetDict objectForKey:@"title"] == [NSNull null]){
//    tempObject.title = @"N/A";
//}
//else {
//    tempObject.title = [allGetDict objectForKey:@"title"];
//}
//if ([allGetDict objectForKey:@"author"] == [NSNull null]){
//    tempObject.author = @"N/A";
//}
//else {
//    tempObject.author = [allGetDict objectForKey:@"author"];
//}
//
////                    if ([allGetDict objectForKey:@"lastCheckedOutBy"] == [NSNull null])
////                    {
////                            tempObject.lastDateCheckedOutBy = @"N/A";
////                    }
//tempObject.lastDateCheckedOutBy = [allGetDict objectForKey:@"lastCheckedOutBy"];
//
//if ([allGetDict objectForKey:@"lastCheckedOut"] == [NSNull null])
//{
//    tempObject.lastCheckedOutDate = nil;
//
//} else {
//    tempObject.lastCheckedOutDate = [allGetDict objectForKey:@"lastCheckOut"];
//}
//tempObject.categories = [allGetDict objectForKey:@"cateories"];
//tempObject.publisher = [allGetDict objectForKey:@"publisher"];
//tempObject.ID = [allGetDict objectForKey:@"id"];

@end
