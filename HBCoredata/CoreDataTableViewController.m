//
//  CoreDataTableViewController.m
//  HBCoredata
//
//  Created by SourceKode on 14/12/14.
//  Copyright (c) 2014 iHrishikesh. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <Coredata/Coredata.h>
#import "AppDelegate.h"
#import "HBEntity.h"

@interface CoreDataTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSFetchedResultsController *controller;

@end



@implementation CoreDataTableViewController

-(NSManagedObjectContext *) managedObjectContext{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    return appDelegate.managedObjectContext;
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath{
    
    if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] initWithEntityName:@"HBEntity"];
    
    NSSortDescriptor *firstNameSort = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO];
    
    fetchRequest.sortDescriptors = @[firstNameSort];
    
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    self.controller.delegate = self;
   
    NSError *fetchError = nil;
    
    if([self.controller performFetch:&fetchError]){
        NSLog(@"Successfully Fetched");
    }else{
        NSLog(@"Fetching Failed");
    }
    
    
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> sectionInfo = self.controller.sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"coreCellView" forIndexPath:indexPath];
    
    HBEntity *person = [self.controller objectAtIndexPath:indexPath];
    
    cell.textLabel.text = person.firstName;
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        HBEntity *person = [self.controller objectAtIndexPath:indexPath];
        
        [self.managedObjectContext deleteObject:person];
        
        if ([person isDeleted]) {
            NSError *savingError=nil;
            if([self.managedObjectContext save:&savingError]){
                NSLog(@"Successfully Deleted the object....");
            }
            else{
                NSLog(@"Deletion Failed with error: %@",savingError);
            }
        }
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
