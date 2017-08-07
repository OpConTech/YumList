//
//  DetailsTableViewController.h
//  YumList
//
//  Created by Thomas Neary on 8/7/17.
//  Copyright © 2017 OpCon Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewController : UITableViewController

@property (nonatomic) NSString *yumListName;
@property (strong, nonatomic) IBOutlet UILabel *yumListNameLabel;
@property (nonatomic) NSString *yumListQuantity;
@property (strong, nonatomic) IBOutlet UILabel *yumListQuantityLabel;
@property (nonatomic) NSString *yumListDescription;
@property (strong, nonatomic) IBOutlet UILabel *yumListDescriptionLabel;
@property (nonatomic) NSString *yumListInBasket;
@property (strong, nonatomic) IBOutlet UILabel *yumListInBasketLabel;
@end
