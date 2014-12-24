//
//  ViewController.m
//  InstagramPhotoLoader
//
//  Created by Deepak on 12/23/14.
//  Copyright (c) 2014 Personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequestForInstagramUserAuthentication];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequestForInstagramUserAuthentication{
    

    NSString *requestTokenURLString = [NSString stringWithFormat:kFETCH_ACCESS_TOKEN_URL_PARAMS,KAUTHURL,KCLIENTID,kREDIRECTURI];
    NSString* requestTokenURLStringEncoded = [requestTokenURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* finalRequestTokenURL = [NSURL URLWithString:requestTokenURLStringEncoded];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:finalRequestTokenURL];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _webview=[[UIWebView alloc]initWithFrame:screenBounds];
    [_webview loadRequest:requestObj];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
}

/********************************************** UIWEBVIEW DELEGATE *****************************************/

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString* urlString = [[request URL] absoluteString];
  
    NSArray *urlParts = [urlString componentsSeparatedByString:[NSString stringWithFormat:@"%@/",kREDIRECTURI]];
    if ([urlParts count] > 1) {
      
        urlString = [urlParts objectAtIndex:1];
        NSRange accessToken = [urlString rangeOfString:kACCESS_TOKEN_URL_PARAM];
        if (accessToken.location != NSNotFound) {
            NSString* strAccessToken = [urlString substringFromIndex: NSMaxRange(accessToken)];
            
            [[NSUserDefaults standardUserDefaults] setValue:strAccessToken forKey:kACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
           
            [self loadRequestForMediaData];
        }
        return NO;
    }
    return YES;
}

- (void)loadRequestForMediaData {
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:kFETCH_MEDIA_URL,kAPIURL,[[ NSUserDefaults standardUserDefaults]valueForKey:kACCESS_TOKEN]]]];
   
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *imagedDictionary =[[[responseDictionary objectForKeyedSubscript:REPONSE_DATA_DICTIONARY_KEY]objectAtIndex:0]objectForKey:REPONSE_IMAGES_DICTIONARY_KEY];
    NSMutableArray *imageUrlArray =[[NSMutableArray alloc]init];
    
    
    NSDictionary *stdResolutionImageDictionary = [imagedDictionary objectForKey:REPONSE_IMAGE_STD_RESOLUTION_KEY];
    NSString *std_url=[stdResolutionImageDictionary objectForKey:REPONSE_IMAGE_URL_KEY];
    [imageUrlArray addObject:std_url];
    
    NSDictionary *lowResolutionImageDictionary = [imagedDictionary objectForKey:REPONSE_IMAGE_LOW_RESOLUTION_KEY];
    NSString *low_url=[lowResolutionImageDictionary objectForKey:REPONSE_IMAGE_URL_KEY];
    [imageUrlArray addObject:low_url];
    
    NSDictionary *thumbnailImageDictionary = [imagedDictionary objectForKey:REPONSE_IMAGE_THUMBMAIL_KEY];
    NSString *thumb_url=[thumbnailImageDictionary objectForKey:REPONSE_IMAGE_URL_KEY];
    [imageUrlArray addObject:thumb_url];
    
    
    ImagesTableViewController *tableViewController =[[ImagesTableViewController alloc]init];
    
    tableViewController.imageUrlArray=imageUrlArray;
    
    [self.navigationController pushViewController:tableViewController animated:YES];
    
}


@end
