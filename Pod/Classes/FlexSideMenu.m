//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <UIKit/UIKit.h>
#import "FlexSideMenu.h"
#import "FlexSideMenuAnimator.h"
#import "FlexContainerViewController.h"
#import "FlexSideMenuContainerViewController.h"
#import "FlexSideMenuDelegate.h"
#import <UIKit/UIScreenEdgePanGestureRecognizer.h>

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
    _leftEdgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    self.leftEdgePanRecognizer.edges = UIRectEdgeLeft;
    self.leftEdgePanRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.leftEdgePanRecognizer];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGesture.delegate = self;
    [self.contentController.view addGestureRecognizer:self.panGesture];
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    self.tapGesture.delegate = self;
    [self.contentController.view addGestureRecognizer:self.tapGesture];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gestureRecognizer {
    if(self.isMenuVisible && gestureRecognizer.state == UIGestureRecognizerStateEnded)
        [self hideSidebarViewController:nil];
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)gestureRecognizer {
    CGPoint velocityInView = [gestureRecognizer velocityInView:self.view];
    if(velocityInView.x < 0 && self.isMenuVisible && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self hideSidebarViewController:nil];
    }
}

- (void)handleLeftEdgeGesture:(UIGestureRecognizer*)gestureRecognizer {
    if(!self.isMenuVisible && gestureRecognizer.state == UIGestureRecognizerStateBegan)
        [self showSidebarViewControllerFromSide:Left];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return (![gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]] && self.isMenuVisible) || [gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]];
}

- (void)toggleLeftMenu {
    if (_isMenuVisible) {
        [self hideSidebarViewController:nil];
    }
    else {
        [self showSidebarViewControllerFromSide:Left];
    }
}

- (void)toggleRightMenu {
    if (_isMenuVisible) {
        [self hideSidebarViewController:nil];
    }
    else {
        [self showSidebarViewControllerFromSide:Right];
    }
}

- (void)showSidebarViewControllerFromSide:(enum FlexMenuPosition)position
{
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
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.animator showSideMenuAnimated:self.selectedSideMenuContainer
                       contentContainer:self.contentContainer
                               duration:self.animationDuration
                             completion:^(BOOL finished) {
                                 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                 [self disableContentInterationsIfNeeded];
                                 self.isMenuVisible = YES;
                                 [self notifyMenuDidShow];
                             }
     ];
    
    
}

- (void)hideSidebarViewController:(void (^)(void))onCompletion {
    [self notifyMenuWillHide];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.animator hideSideMenuAnimated:self.selectedSideMenuContainer
                       contentContainer:self.contentContainer
                               duration:self.animationDuration
                             completion:^(BOOL finished) {
                                 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                 [self enableContentInteractionsIfDisabled];
                                 self.isMenuVisible = NO;
                                 [self notifyMenuDidHide];
                                 if(onCompletion) {
                                    onCompletion();
                                 }
                             }
     ];
}

- (void) disableContentInterationsIfNeeded {
    if([self.contentController isKindOfClass:[UINavigationController class]]) {
        ((UINavigationController *)self.contentController).navigationBar.userInteractionEnabled = NO;
    }
}

- (void) enableContentInteractionsIfDisabled {
    if([self.contentController isKindOfClass:[UINavigationController class]]) {
        ((UINavigationController *)self.contentController).navigationBar.userInteractionEnabled = YES;
    }
}

#pragma Notifying delegates
- (void)notifyMenuDidShow {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:didShowViewController:)]) {
        [self.delegate sideMenuController:self didShowViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

- (void)notifyMenuWillShow {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:willShowViewController:)]) {
        [self.delegate sideMenuController:self willShowViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

- (void)notifyMenuDidHide {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:didHideViewController:)]) {
        [self.delegate sideMenuController:self didHideViewController:self.selectedSideMenuContainer.containedViewController];
    }
}

- (void)notifyMenuWillHide {
    if([self.delegate conformsToProtocol:@protocol(FlexSideMenuDelegate)] && [self.delegate respondsToSelector:@selector(sideMenuController:willHideViewController:)]) {
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

- (UIViewController *)leftMenuController {
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
    if([self.parentViewController.parentViewController isKindOfClass:[FlexSideMenu class]]) {
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
