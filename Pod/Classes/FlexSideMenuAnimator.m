//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import "FlexSideMenuAnimator.h"
#import "FlexSideMenu.h"
#import "FlexSideMenuContainerViewController.h"
#import "FlexSideMenuAnimator+SubClass.h"


@implementation FlexSideMenuAnimator {

}
+ (void)load {
    [super load];
    [FlexSideMenu registerAnimation:self];
}

- (void)showSideMenuAnimated:(FlexSideMenuContainerViewController *)menuContainer contentContainer:(FlexContainerViewController *)contentContainer duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
    UIView *sidebarView = menuContainer.view;
    UIView *contentView = contentContainer.view;
    
    [self resetSidebarPosition:sidebarView];
    [self resetContentPosition:contentView];
    
    
    CGRect contentFrame = contentView.frame;
    
    if(menuContainer.menuSide == Left)
    {
        contentFrame.origin.x += [self menuWidth];
    }
    else
    {
        contentFrame.origin.x -= [self menuWidth];
    }
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         contentView.frame = contentFrame;
                     }
                     completion:^(BOOL finished) {
                         completion(finished);
                     }];
    
}

- (void)hideSideMenuAnimated:(FlexSideMenuContainerViewController *)menuContainer contentContainer:(FlexContainerViewController *)contentContainer duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
    UIView *contentView = contentContainer.view;
    
    CGRect contentFrame = contentView.frame;
    contentFrame.origin.x = 0;
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         contentView.frame = contentFrame;
                     }
                     completion:^(BOOL finished) {
                         completion(finished);
                     }];
    
}

@end
