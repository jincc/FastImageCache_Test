//
//  TableViewController.m
//  IRanderTest
//
//  Created by junlongj on 16/1/12.
//  Copyright © 2016年 junlongj. All rights reserved.
//

#import "TableViewController.h"
#import "Cell.h"
#import "UIImageView+SCFastImageCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SCFPSLabel.h"
#import <KMCGeigerCounter.h>
@interface TableViewController ()
{
    NSArray *_items;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [[KMCGeigerCounter sharedGeigerCounter]setEnabled:true];
    _items = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weibo_avatars" ofType:@"plist"]];
    
#define SCShowFPS     SCFPSLabel *label = [[SCFPSLabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];\
    self.navigationItem.titleView = label;
    
    SCShowFPS;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *url = _items[indexPath.row];
    [cell.imgView sc_setImageWithURL:[NSURL URLWithString:url]];
//     [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
