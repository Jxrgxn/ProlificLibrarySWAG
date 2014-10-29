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

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
@property (strong, nonatomic) NSMutableArray *allBooksArray;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bookTableView.delegate = self;
    self.allBooksArray = [NSMutableArray new];

    self.navigationController.navigationBar.barTintColor = [UIColor redColor];

    NSString *getAll = [NSString stringWithFormat:@"%@books", apiPath];
    NSLog(@"%@", getAll);
    //NSURLRequest *getAllrequest = [NSURLRequest requestWithURL:getAll];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getAll parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *responseArray = responseObject;
            for (NSDictionary *allGetDict in responseArray){
                {
                    BookData *tempObject = [BookData new];
                    tempObject.author = [allGetDict objectForKey:@"author"];
                    tempObject.categories = [allGetDict objectForKey:@"cateories"];
                    tempObject.title = [allGetDict objectForKey:@"title"];
                    tempObject.lastCheckedOutDate = [allGetDict objectForKey:@"lastCheckedOut"];
                    tempObject.publisher = [allGetDict objectForKey:@"publisher"];
                    tempObject.ID = [allGetDict objectForKey:@"id"];
                    [self.allBooksArray addObject:tempObject];
                }
            }
            NSLog(@"Array contains: %@", self.allBooksArray);
            [self.bookTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Library"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

    NSLog(@"Exit");
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Where are we going?
    BookDetailViewController *detailvc = segue.destinationViewController;
    NSIndexPath *detailPath = [self.bookTableView indexPathForSelectedRow];
    detailvc.bookDetailObject = self.allBooksArray[detailPath.row];

}
@end
