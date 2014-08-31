//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <UIKit/UIKit.h>
#import "FlexSideMenu.h"
#import "FlexSideMenuAnimator.h"
#import "FlexContainerViewController.h"
#import "FlexSideMenuContainerViewController.h"
#import "FlexSideMenuDelegate.h"

@interface FlexSideMenu ()

@property(nonatomic, strong) FlexSideMenuContainerViewController *leftSideMenuContainer;
@property(nonatomic, strong) FlexSideMenuContainerViewController *rightSideMenuContainer;
@property(nonatomic, strong) FlexSideMenuContainerViewController *selectedSideMenuContainer;
@property(nonatomic, strong) FlexContainerViewController *contentContainer;
@property(nonatomic, strong) FlexSideMenuAnimator *animator;
@property(nonatomic, assign) NSTimeInterval animationDuration;
@end

@implementation FlexSideMenu
static NSMutableArray *animationClasses;
+ (NSMutableArray *)animationClasses {
    if(!animationClasses) {
        animationClasses = [NSMutableArray array];
    }
    return animationClasses;
}

+ (void)registerAnimation:(Class)animationClass {
    [self.animationClasses addObject:animationClass];
}

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController leftSideMenuController:(UIViewController *)leftSideMenuController rightSideMenuController:(UIViewController *)rightSideMenuController usesAutoLayout:(BOOL)usesAutoLayout animator:(FlexSideMenuAnimator *)animator {
    self = [super init];
    if (self) {
        self.leftSideMenuContainer = [[FlexSideMenuContainerViewController alloc] initWithContainedViewController:leftSideMenuController menuPosition:Left];
        self.rightSideMenuContainer = [[FlexSideMenuContainerViewController alloc] initWithContainedViewController:rightSideMenuController menuPosition:Right];
        
        self.contentContainer = [[FlexContainerViewController alloc] initWithContainedViewController:contentViewController];
        
        self.usesAutoLayout = usesAutoLayout;
        self.animator = animator;
        self.animationDuration = 0.25;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = self.usesAutoLayout;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSideMenuContainer:self.leftSideMenuContainer];
    [self addSideMenuContainer:self.rightSideMenuContainer];
    [self addViewContainer:self.contentContainer];
}

- (void)toggleLeftMenu {
    if (_isMenuVisible) {
        [self hideSidebarViewController];
    }
    else {
        [self showSidebarViewControllerFromSide:Left];
    }
}

- (void)showSidebarViewControllerFromSide:(enum FlexMenuPosition)position
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    if(position == Left)
    {
        [self.rightSideMenuContainer hideView];
        [self.leftSideMenuContainer showView];
        self.selectedSideMenuContainer = self.leftSideMenuContainer;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    }
    else
    {
        [self.rightSideMenuContainer showView];
        [self.leftSideMenuContainer hideView];
        self.selectedSideMenuContainer = self.rightSideMenuContainer;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    }
    
    [self notifyMenuWillShow];
    
//    [self transitionFromViewController:self.contentContainer toViewController:self.selectedSideMenuContainer duration:self.animationDuration options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.animator showSideMenuAnimated:self.selectedSideMenuContainer
                           contentContainer:self.contentContainer
                                   duration:self.animationDuration
                                 completion:^(BOOL finished) {
                                     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                     self.isMenuVisible = YES;
                                     [self notifyMenuDidShow];
                                 }
         ];
//    } completion:nil];
    
         
}

- (void)hideSidebarViewController {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [self notifyMenuWillHide];
    [self.animator hideSideMenuAnimated:self.selectedSideMenuContainer
                       contentContainer:self.contentContainer
                               duration:self.animationDuration
                             completion:^(BOOL finished) {
                                 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                 self.isMenuVisible = NO;
                                 [self notifyMenuDidHide];
                             }
     ];
}

#pragma Notifying delegates
- (void)notifyMenuDidShow {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:didShowViewController:)])
    {
        [self.delegate sideMenuController:self didShowViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

- (void)notifyMenuWillShow {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:willShowViewController:)])
    {
        [self.delegate sideMenuController:self willShowViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

- (void)notifyMenuDidHide {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:didHideViewController:)])
    {
        [self.delegate sideMenuController:self didHideViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

- (void)notifyMenuWillHide {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:willHideViewController:)])
    {
        [self.delegate sideMenuController:self willHideViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

#pragma adding child controllers
- (void)addSideMenuContainer:(FlexSideMenuContainerViewController *)sideMenuContainer {
    // Container View Controller
    [self addViewContainer:sideMenuContainer];
    sideMenuContainer.view.translatesAutoresizingMaskIntoConstraints = self.usesAutoLayout;
    [sideMenuContainer hideView];
}

- (void)addViewContainer:(UIViewController *)sideMenuContainer {
    [self addChildViewController:sideMenuContainer];
    [self.view addSubview:sideMenuContainer.view];
    [sideMenuContainer didMoveToParentViewController:self];
}

- (UIViewController *)leftMenuController
{
    return self.leftSideMenuContainer.containedViewController;
}

- (UIViewController*)contentController {
    return self.contentContainer.containedViewController;
}


- (void)setContentController:(UIViewController *)newContentController {
    [self.contentContainer setContentController:newContentController];
}

@end

@implementation UIViewController(FlexSideMenu)

- (FlexSideMenu *)sideMenu
{
    if([self.parentViewController.parentViewController isKindOfClass:[FlexSideMenu class]])
    {
        return (FlexSideMenu *)self.parentViewController.parentViewController;
    }
    else if([self.parentViewController isKindOfClass:[UINavigationController class]] &&
            [self.parentViewController.parentViewController.parentViewController isKindOfClass:[FlexSideMenu class]])
    {
        return (FlexSideMenu *)self.parentViewController.parentViewController.parentViewController;
    }
    
    return nil;
}

@end
