//
//  ImagesTableViewController.h
//  TestInstagram
//
//  Created by Deepak on 12/21/14.
//  Copyright (c) 2014 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface ImagesTableViewController : UITableViewController
{
    float rowHeight;

}

@property(nonatomic,strong)NSMutableArray *imageUrlArray;

@end
