//
//  FirstViewController.m
//  ParceDemo
//
//  Created by MitulB on 18/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize arrList;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataFromList];
}


-(void)getDataFromList
{
    if (httpCallAPI){
        
        [httpCallAPI cancelRequest];
        httpCallAPI.delegate = nil;
        httpCallAPI = nil;
    }
    httpCallAPI = [[HttpWrapper alloc]init];
    httpCallAPI.delegate = self;
    
    NSMutableDictionary *dictParam = [[NSMutableDictionary alloc]init];
    [dictParam setValue:@"userfavorite" forKey:@"action"];
    [dictParam setValue:@"usersList" forKey:@"type"];
    [dictParam setValue:@"1" forKey:@"userid"];
    [httpCallAPI requestWithMethod:@"POST" url:@"http://45.55.140.34/webservice/index.php" param:dictParam];
}

- (void) HttpWrapper:(HttpWrapper *)wrapper fetchDataSuccess:(NSMutableDictionary *)dicsResponse
{
    if (wrapper == httpCallAPI)
    {
        NSLog(@"Dict Responce %@", dicsResponse);
        
        arrList = [[NSMutableArray alloc]init];
        for(NSDictionary *dict in [dicsResponse objectForKey:@"teamList"]){
            [arrList addObject:dict];
            NSLog(@"dic %@", dict);
        }
        [tblList reloadData];
    }
}
- (void) HttpWrapper:(HttpWrapper *)wrapper fetchDataFail:(NSError *)error
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [arrList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = [arrList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"username"];
    cell.detailTextLabel.text = [dict objectForKey:@"useremail"];
    
    return cell;
    
}


/*
 
-(void)uploadImage:(NSString *)imagePath withTitle:(NSString *)vidTitle withLat:(NSString *)strLat withLong:(NSString *)strLong
{
    // for stop all background dowload request who running for download
    for (ASIHTTPRequest *runningRequest in ASIHTTPRequest.sharedQueue.operations){
        [runningRequest cancel];
        [runningRequest setDelegate:nil];
    }
    
    NSURL *strUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@?action=imageUpload",Base_URL]];
    
    upImgRequest = [[ASIFormDataRequest alloc] initWithURL:strUrl];
    [upImgRequest setRequestMethod:@"POST"];
    [upImgRequest setPostFormat:ASIMultipartFormDataPostFormat];
    
    [upImgRequest setTimeOutSeconds:100];
    
    NSString *vendorId  = [[AppDelegate sharedAppDelegate] getVendorId];
    
    NSString *imgPath = [[[AppDelegate sharedAppDelegate] applicationCacheDirectory] stringByAppendingPathComponent:@"Images"];
    imgPath = [imgPath stringByAppendingPathComponent:@"uploadImage.png"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    
    
    NSData *imagdata = UIImageJPEGRepresentation(image, 1.0);
    [upImgRequest setData:imagdata withFileName:@"thumb.png" andContentType:@"image/jpeg" forKey:@"thumb_image"];
    [upImgRequest setPostValue:vidTitle forKey:@"imageTitle"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [userDefault objectForKey:DEVICE_TOKEN_KEY];
    if(deviceToken == nil){
        deviceToken = @"";
    }
    [upImgRequest setPostValue:vendorId forKey:@"vendorId"];
    [upImgRequest setPostValue:deviceToken forKey:@"vendorDeviceId"];
    [upImgRequest setPostValue:strLat forKey:@"videolatitude"];
    [upImgRequest setPostValue:strLong forKey:@"videolongitude"];
    
    [upImgRequest setPostValue:[AppDelegate sharedAppDelegate].strIpAddress forKey:@"vendorip"];
    
    [upImgRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [upImgRequest setUseCookiePersistence:NO];
    [upImgRequest setUseSessionPersistence:NO];
    [upImgRequest setDelegate:self];
    [upImgRequest setDidFinishSelector:@selector(uploadImageRequestFinished:)];
    [upImgRequest setDidFailSelector:@selector(uploadImageRequestFailed:)];
    [upImgRequest setShouldContinueWhenAppEntersBackground:YES];
    [upImgRequest setShowAccurateProgress:YES];
    [upImgRequest setShouldContinueWhenAppEntersBackground:YES];
    [upImgRequest startAsynchronous];
}
 
- (void)uploadImageRequestFinished:(ASIHTTPRequest *)request1
{
    NSError *error = [request1 error];
    // [[AppDelegate sharedAppDelegate]hidePersentLoading];
    if (!error)
    {
        NSString *response = [request1 responseString];
        NSLog(@"parsing response >>>> %@", response);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableDictionary *dict = [parser objectWithString:response];
    }
}
- (void)uploadImageRequestFailed:(ASIHTTPRequest *)request1
{
    NSError *error = [request1 error];
    NSLog(@"IMAGE UPLOAD ERROR  :%@", error);
} 
 
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
