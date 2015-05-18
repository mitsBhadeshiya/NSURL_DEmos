//
//  FirstViewController.h
//  ParceDemo
//
//  Created by MitulB on 18/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpWrapper.h"

@interface FirstViewController : UIViewController <UITableViewDataSource , UITableViewDelegate ,HttpWrapperDelegate>
{
    HttpWrapper *httpCallAPI;
    
    IBOutlet UITableView *tblList;
}
@property (strong , nonatomic) NSMutableArray *arrList;

@end
