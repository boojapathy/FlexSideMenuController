//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <Foundation/Foundation.h>
#import "FlexSideMenuContainerViewController.h"


@interface FlexSideMenuAnimator : NSObject
- (void)showSideMenuAnimated:(FlexSideMenuContainerViewController *)menuContainer contentContainer:(FlexContainerViewController *)contentContainer duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion;

- (void)hideSideMenuAnimated:(FlexSideMenuContainerViewController *)menuContainer contentContainer:(FlexContainerViewController *)contentContainer duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion;
@end
