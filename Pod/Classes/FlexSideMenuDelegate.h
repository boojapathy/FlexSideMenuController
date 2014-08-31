//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <Foundation/Foundation.h>
#import "FlexSideMenu.h"

@protocol FlexSideMenuDelegate <NSObject>
@optional
- (void)sideMenuController:(FlexSideMenu *)menu willShowViewController:(UIViewController *)controller;

- (void)sideMenuController:(FlexSideMenu *)menu didShowViewController:(UIViewController *)controller;

- (void)sideMenuController:(FlexSideMenu *)menu willHideViewController:(UIViewController *)controller;

- (void)sideMenuController:(FlexSideMenu *)menu didHideViewController:(id)didHideViewController;
@end
