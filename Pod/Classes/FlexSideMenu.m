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
        CATransform3D initialTransform = leftSideMenuController.view.layer.sublayerTransform;
        initialTransform.m34 = -1.0f / 800;
        leftSideMenuController.view.layer.transform = initialTransform;
        leftSideMenuController.view.layer.zPosition = 100;
        
        self.leftSideMenuContainer = [[FlexSideMenuContainerViewController alloc] initWithContainedViewController:leftSideMenuController menuPosition:Left];
        self.rightSideMenuContainer = [[FlexSideMenuContainerViewController alloc] initWithContainedViewController:rightSideMenuController menuPosition:Right];
        //        CGRect contentFrame = contentViewController.view.frame;
        //
        //        contentFrame.origin.x = 10;
        //        contentViewController.view.frame = contentFrame;
        
        
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
    [self.contentContainer addViewControllerToContainer];
    
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
        [self.leftSideMenuContainer hideView];
        [self.rightSideMenuContainer showView];
        self.selectedSideMenuContainer = self.leftSideMenuContainer;
    }
    else
    {
        [self.rightSideMenuContainer hideView];
        [self.leftSideMenuContainer showView];
        self.selectedSideMenuContainer = self.rightSideMenuContainer;
    }
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    
    [self notifyMenuWillShow];
    
    [self.animator showSideMenuAnimated:self.selectedSideMenuContainer
                       contentContainer:self.contentContainer
                               duration:self.animationDuration
                             completion:^(BOOL finished) {
                                 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                 self.isMenuVisible = YES;
                                 
                                 [self notifyMenuDidShow];
                             }
     ];
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

- (void)addSideMenuContainer:(FlexSideMenuContainerViewController *)sideMenuContainer {
    // Container View Controller
    [self addViewContainer:sideMenuContainer];
    sideMenuContainer.view.translatesAutoresizingMaskIntoConstraints = self.usesAutoLayout;
    sideMenuContainer.view.hidden = YES;
    [sideMenuContainer addViewControllerToContainer];
}

- (void)addViewContainer:(UIViewController *)sideMenuContainer {
    [self addChildViewController:sideMenuContainer];
    [self.view addSubview:sideMenuContainer.view];
    [sideMenuContainer didMoveToParentViewController:self];
}

@end