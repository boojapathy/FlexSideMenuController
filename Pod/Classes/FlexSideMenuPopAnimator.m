//
//  FlexSideMenuPopAnimator.m
//  Pods
//
//  Created by Boojapathy Chidambaram on 8/27/14.
//
//

#import <pop/POPSpringAnimation.h>
#import "FlexSideMenuPopAnimator.h"
#import "FlexSideMenuContainerViewController.h"
#import "FlexContainerViewController.h"
#import "FlexSideMenuAnimator+SubClass.h"
#import "POPBasicAnimation.h"
#import "FlexSideMenu.h"


@implementation FlexSideMenuPopAnimator {
    
}
- (void)showSideMenuAnimated:(FlexSideMenuContainerViewController *)menuContainer contentContainer:(FlexContainerViewController *)contentContainer duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
    UIView *sidebarView = menuContainer.view;
    UIView *contentView = contentContainer.containedViewController.view;
    
    [self resetSidebarPosition:sidebarView];
    [self resetContentPosition:contentView];
    
//    CGRect contentFrame = contentView.frame;
//    
//    if(menuContainer.menuSide == Left)
//    {
//        contentFrame.origin.x += [self menuWidth];
//    }
//    else
//    {
//        contentFrame.origin.x -= [self menuWidth];
//    }
    
    POPBasicAnimation *contentTranslationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
    contentTranslationAnimation.fromValue = @(0);
    contentTranslationAnimation.toValue = @(-0.5);
    contentTranslationAnimation.duration = 0.4;
    [contentView.layer pop_addAnimation:contentTranslationAnimation forKey:@"menuTranslationAnimation"];
    
    POPBasicAnimation *contentScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleY];
    contentScaleAnimation.fromValue = @(1); // minus 90 degrees
    contentScaleAnimation.toValue = @(0.80);                // facing to users
    contentScaleAnimation.duration = 0.4;
    contentScaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [contentView pop_addAnimation:contentScaleAnimation forKey:@"menuScaleAnimation"];
    
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationX];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake([self menuWidth]-30, 0)];
    anim.dynamicsFriction = 6;
    anim.dynamicsTension = 30;
    anim.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        completion(finished);
    };
    [contentView.layer pop_addAnimation:anim forKey:@"size"];
}

- (void)hideSideMenuAnimated:(FlexSideMenuContainerViewController *)menuContainer contentContainer:(FlexContainerViewController *)contentContainer duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion {
    UIView *contentView = contentContainer.containedViewController.view;
    POPBasicAnimation *contentTranslationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
    contentTranslationAnimation.fromValue = @(-0.5); // minus 90 degrees
    contentTranslationAnimation.toValue = @(0);                // facing to users
    contentTranslationAnimation.duration = 0.4;
    [contentView.layer pop_addAnimation:contentTranslationAnimation forKey:@"menuTranslationAnimation"];
    
    POPBasicAnimation *contentScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleY];
    contentScaleAnimation.fromValue = @(0.80); // minus 90 degrees
    contentScaleAnimation.toValue = @(1);                // facing to users
    contentScaleAnimation.duration = 0.4;
    [contentView pop_addAnimation:contentScaleAnimation forKey:@"menuScaleAnimation"];
    
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPLayerTranslationX];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    anim.dynamicsFriction = 6;
    anim.dynamicsTension = 30;
    anim.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        completion(finished);
    };
    [contentView.layer pop_addAnimation:anim forKey:@"size"];
}

@end