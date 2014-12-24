//
//  ViewController.h
//  InstagramPhotoLoader
//
//  Created by Deepak on 12/23/14.
//  Copyright (c) 2014 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesTableViewController.h"

#define REPONSE_DATA_DICTIONARY_KEY @"data"
#define REPONSE_IMAGES_DICTIONARY_KEY @"images"
#define REPONSE_IMAGE_STD_RESOLUTION_KEY @"standard_resolution"
#define REPONSE_IMAGE_LOW_RESOLUTION_KEY @"low_resolution"
#define REPONSE_IMAGE_THUMBMAIL_KEY @"thumbnail"
#define REPONSE_IMAGE_URL_KEY @"url"


@interface ViewController : UIViewController<UIWebViewDelegate>
{
    
    UIWebView* _webview;
}



@end

