//
//  YumListTableViewController.h
//  YumList
//
//  Created by Thomas Neary on 8/6/17.
//  Copyright © 2017 OpCon Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YumListTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *yumListArray;
@property (nonatomic) NSMutableArray *yumListDescriptionsArray;
@property (nonatomic) NSMutableArray *yumListQuantitiesArray;
@property (nonatomic) NSMutableArray *yumListInTheBasketArray;

@end
