//
//  ImagesTableViewController.m
//  TestInstagram
//
//  Created by Deepak on 12/21/14.
//  Copyright (c) 2014 Personal. All rights reserved.
//

#import "ImagesTableViewController.h"
#define NUMBER_OF_SECTIONS 1

@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController
@synthesize imageUrlArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    rowHeight=0;
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)showSelectedImageinFullScreen:(TableViewCell*)cell{
    
    CGRect convertedRect = [self.view.window convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    [cell.imageView setFrame:convertedRect];
    [self.view.window addSubview:cell.imageView];
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        [cell.imageView setFrame:[[UIScreen mainScreen] bounds]];
    }completion:^(BOOL finished){
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageUrlArray.count;
}

/********************************UITABLEVIEW DELEGATE METHODS*********************************/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *cellIdentifier = @"reuseIdentifier";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseIdentifier"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
       
    }

    
    NSURL *imageUrl = [NSURL URLWithString:[self.imageUrlArray objectAtIndex:indexPath.row]];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    [cell.imageView setImage:img];
    cell.imageView.contentMode=UIViewContentModeScaleToFill;
    cell.imageView.frame = CGRectMake(cell.imageView.frame.origin.x, cell.imageView.frame.origin.y,img.size.width, img.size.height);
    rowHeight=img.size.height;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = (TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self showSelectedImageinFullScreen:cell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

@end
