//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FlexSideMenuDelegate;
@class FlexSideMenuAnimator;

enum FlexMenuPosition {
    Right,
    Left
};

@interface FlexSideMenu : UIViewController
@property (assign, nonatomic) BOOL usesAutoLayout;

@property(nonatomic, assign) BOOL isMenuVisible;

@property(nonatomic, assign) id<FlexSideMenuDelegate> delegate;

+ (void)registerAnimation:(Class)sideMenuAnimation;

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController leftSideMenuController:(UIViewController *)leftSideMenuController rightSideMenuController:(UIViewController *)rightSideMenuController usesAutoLayout:(BOOL)usesAutoLayout animator:(FlexSideMenuAnimator *)animator;

- (void)toggleLeftMenu;

- (void)hideSidebarViewController;

@end