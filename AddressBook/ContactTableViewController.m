//
//  ContactTableViewController.m
//  ContactLish
//
//  Created by 高青松 on 16/7/18.
//  Copyright © 2016年 高青松. All rights reserved.
//

#import "ContactTableViewController.h"
#import "AddContactViewController.h"
#import "ContactModel.h"
#import "EditContactViewController.h"
@interface ContactTableViewController ()<AddContactDelegate,EditDelegate>
- (IBAction)backAction:(id)sender;
@property (nonatomic,strong)NSMutableArray *contactArray;

@end

#define ContactFilePath     [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"contacts.data"]
@implementation ContactTableViewController
- (NSMutableArray *)contactArray
{
    if (!_contactArray) {
        _contactArray = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        if (_contactArray == nil) {
            _contactArray = [NSMutableArray array];
        }
    }
    return _contactArray;
}

- (void)addContactOfController:(UIViewController *)controller addContact:(ContactModel *)model
{
    [self.contactArray addObject:model];
    [self.tableView reloadData];
    
    [NSKeyedArchiver archiveRootObject:self.contactArray toFile:ContactFilePath];
    
}

- (void)editContactController:(UIViewController *)vc editContact:(ContactModel *)model
{
//    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
//    [self.contactArray removeObjectAtIndex:path.row];
//    [self.contactArray addObject:model];
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArray toFile:ContactFilePath];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearExtraLine:self.tableView];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contactArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            [NSKeyedArchiver archiveRootObject:self.contactArray toFile:ContactFilePath];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    ContactModel *model = self.contactArray[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)clearExtraLine:(UITableView *)tableView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    AddContactViewController *addVc = segue.destinationViewController;
//    addVc.delegate = self;
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[AddContactViewController class]]) {
        AddContactViewController *addVc = vc;
        addVc.delegate = self;
    }
    else
    {
        EditContactViewController *editVc = vc;
        editVc.delegate = self;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVc.model = self.contactArray[path.row];
    }
}


- (IBAction)backAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"真的注销吗" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
@end
