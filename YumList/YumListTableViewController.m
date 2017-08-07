//
//  YumListTableViewController.m
//  YumList
//
//  Created by Thomas Neary on 8/6/17.
//  Copyright © 2017 OpCon Technologies, Inc. All rights reserved.
//

#import "YumListTableViewController.h"

@interface YumListTableViewController ()

@end

@implementation YumListTableViewController

@synthesize yumListArray;
@synthesize yumListDescriptionsArray;
@synthesize yumListQuantitiesArray;
@synthesize yumListInTheBasketArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // ***
    // Setup Navigation Bar Title, Add and Remove Item Buttons...
    // ***
    self.navigationItem.title = @"YumList";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"Remove Item";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemToYumList:)];
    self.navigationItem.leftBarButtonItem = addButton;
    
    // ***
    // Setup the YumList
    // ***
    
    // Item Names
    yumListArray = [NSMutableArray arrayWithObjects: @"Milk",@"Donuts", @"Coffee", @"Sugar", @"Creme", @"Famous Amos Cookies", nil];
    
    //Item Quantites
    yumListQuantitiesArray = [NSMutableArray arrayWithObjects: @"1",@"10", @"2", @"1", @"1", @"1000",nil];
    
    //Item Descriptions
    yumListDescriptionsArray = [NSMutableArray arrayWithObjects: @"Got Milk?",@"Mmmm Donuts", @"Coffeeeeeee", @"Dominos Sugar Cubes", @"Half and Half", @"Chocolate Chip..Mmmmm",nil];
    
    //Items in Grocery Basket
    yumListInTheBasketArray = [NSMutableArray arrayWithObjects: @"No",@"Yes", @"No", @"No", @"0No", @"Yes",nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [tableView setRowHeight:60.0f];
    return self.yumListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.yumListArray objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.yumListQuantitiesArray objectAtIndex:indexPath.row]];
    
    
    if ([[self.yumListInTheBasketArray objectAtIndex:indexPath.row] isEqualToString: @"Yes"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
 
    return cell;
}


#pragma mark - Table view rearranging rows
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



#pragma mark - Tableview Deleteing and Adding rows. Changing data in rows.

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    // Make sure you call super first
    [super setEditing:editing animated:animated];
    
    if (editing)
    {
        self.editButtonItem.title = NSLocalizedString(@"Cancel", @"Cancel");
    }
    else
    {
        self.editButtonItem.title = NSLocalizedString(@"Remove Item", @"Remove Item");
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [yumListArray removeObjectAtIndex:indexPath.row];
        [yumListQuantitiesArray removeObjectAtIndex:indexPath.row];
        [yumListDescriptionsArray removeObjectAtIndex:indexPath.row];
        [yumListInTheBasketArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1; //Delete
}



- (void)addItemToYumList:sender {
    NSLog(@"\nAdding Item to List...\n");
    //[self.tableView setEditing:YES animated:YES];
    
    //[yumListArray addObject:@"Beignets"];
    //[yumListQuantitiesArray addObject:@"10"];
    //[yumListInTheBasketArray addObject:@"0"];
    //[self.tableView reloadData];
    
    UIAlertController *alertController1 = [UIAlertController
                                           alertControllerWithTitle:@"Add a Yummy Item"
                                           message:@"to your YumList."
                                           preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController1 addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         //textField.tag = 1;
         textField.placeholder = NSLocalizedString(@"Item Neme", @"Name");
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
         textField.autocorrectionType = UITextAutocorrectionTypeNo;
         textField.returnKeyType = UIReturnKeyNext;
         //textField.secureTextEntry = YES;
         
         [textField setKeyboardAppearance:UIKeyboardAppearanceDark];
         
         // detect changes to the UITextField by adding a target action to the text field
         [textField addTarget:self
                       action:@selector(alertTextFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
         
         
     }];
    
    [alertController1 addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
        // textField.tag = 2;
         textField.placeholder = NSLocalizedString(@"Quantity", @"Quantity");
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
         textField.autocorrectionType = UITextAutocorrectionTypeYes;
         textField.returnKeyType = UIReturnKeyNext;
         //textField.secureTextEntry = YES;
         
         [textField setKeyboardAppearance:UIKeyboardAppearanceDark];
         [textField setKeyboardType:UIKeyboardTypeNumberPad];
         
         // detect changes to the UITextField by adding a target action to the text field
         [textField addTarget:self
                       action:@selector(alertTextFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
         
     }];
    
    
    [alertController1 addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.tag = 3;
         textField.placeholder = NSLocalizedString(@"Description", @"Description");
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
         textField.autocorrectionType = UITextAutocorrectionTypeYes;
         textField.returnKeyType = UIReturnKeyDone;
         //textField.secureTextEntry = YES;
         
         [textField setKeyboardAppearance:UIKeyboardAppearanceDark];
         
         // detect changes to the UITextField by adding a target action to the text field
         //[textField addTarget:self
         //              action:@selector(alertTextFieldDidChange:)
         //    forControlEvents:UIControlEventEditingChanged];
         
         
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Done action")
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"cancelAction");
                                       
                                   }];
    
    
    UIAlertAction *addItemAction = [UIAlertAction
                                          actionWithTitle:NSLocalizedString(@"Add Item", @"OK action")
                                          style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action)
                                          {
                                              
                                              NSLog(@"Add Item action");
                                              
                                              // Receive the name and e-mail from the alert pop up
                                              UITextField *name = alertController1.textFields[0];
                                              UITextField *quantity = alertController1.textFields[1];
                                              UITextField *description= alertController1.textFields[2];
                                              
                                              [yumListArray addObject:name.text];
                                              [yumListQuantitiesArray addObject:quantity.text];
                                              [yumListDescriptionsArray addObject:description.text];
                                              
                                              // And set the checkmark in the check mark array
                                              [yumListInTheBasketArray addObject:@"0"];

                                              [self.tableView reloadData];
                                              
                                              
                                          }]; // end create new group action
    
    [alertController1 addAction:addItemAction];
    // Disable the action button until there is at leaset one character in the Name and Quantity fields
    addItemAction.enabled = NO;
    [alertController1 addAction:cancelAction];
    
    // Present Alert Controller as an Action Sheet with a UIPicker subView
    [self presentViewController:alertController1 animated:YES completion:nil];
    
    
}



- (void)alertTextFieldDidChange:(UITextField *)sender
{
    // Add Item to List Tapped: Validate that Name and Quantity fields in the alert are not left blank...
    
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *name = alertController.textFields[0];
        UITextField *quantity= alertController.textFields[1];
        UIAlertAction *addItemAction = alertController.actions.firstObject;
        addItemAction.enabled = (name.text.length > 0 && quantity.text.length > 0);
        
    }
    
}

 
 
 
#pragma mark - Tableview Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"Details"])
    {
        NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
        NSString *name = [[NSString alloc] init];
        NSString *quantity = [[NSString alloc] init];
        NSString *description = [[NSString alloc] init];
        NSString *inbasket = [[NSString alloc] init];
        name = [yumListArray objectAtIndex:[selectedRow row]];
        quantity = [yumListQuantitiesArray objectAtIndex:[selectedRow row]];
        description = [yumListDescriptionsArray objectAtIndex:[selectedRow row]];
        inbasket = [yumListInTheBasketArray objectAtIndex:[selectedRow row]];
        
        NSLog(@"\nPassing Description to Detail View...Descripiton is: %@\n", description);
        
        
        DetailsTableViewController *vc = [segue destinationViewController];
        vc.title = @"Yummy Details";
        vc.yumListName = name;
        vc.yumListQuantity = quantity;
        vc.yumListDescription = description;
        vc.yumListInBasket = inbasket;
    }
    
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    
    NSLog(@"reaching accessoryButtonTappedForRowWithIndexPath:");
    
    [self performSegueWithIdentifier:@"Details" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    
    if ([[yumListInTheBasketArray objectAtIndex:indexPath.row] isEqualToString: @"No"])
    {
        [yumListInTheBasketArray replaceObjectAtIndex:indexPath.row withObject:@"Yes"];
        [self.tableView reloadData];
    } else {
        [yumListInTheBasketArray replaceObjectAtIndex:indexPath.row withObject:@"No"];
        [self.tableView reloadData];
    }
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"person has selected %@",[yumListArray objectAtIndex:indexPath.row]);
    
    if ([[yumListInTheBasketArray objectAtIndex:indexPath.row] isEqualToString: @"0"])
    {
        [yumListInTheBasketArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        [self.tableView reloadData];
    } else {
        [yumListInTheBasketArray replaceObjectAtIndex:indexPath.row withObject:@"0"];
        [self.tableView reloadData];
    }
    
}


@end
