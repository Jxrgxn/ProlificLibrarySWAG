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

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bookTableView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bookTableView.delegate = self;
    self.bookTableView.dataSource = self;

    self.navigationController.navigationBar.barTintColor = [UIColor redColor];

    NSString *getAll = [NSString stringWithFormat:@"%@books", apiPath];
    NSLog(@"%@", getAll);
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        (NSLog(@"Entro!"));
//    }];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:getAll parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"JSON: %@", error);
    }];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellRow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
