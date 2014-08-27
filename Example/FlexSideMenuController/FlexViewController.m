//
//  FlexViewController.m
//  FlexSideMenuController
//
//  Created by boojapathy on 08/27/2014.
//  Copyright (c) 2014 boojapathy. All rights reserved.
//

#import "FlexViewController.h"
#import <FlexSideMenu.h>

@interface FlexViewController ()

@end

@implementation FlexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu:(UIButton *)sender {
    [((FlexSideMenu *) self.parentViewController.parentViewController) toggleLeftMenu];

}
@end
