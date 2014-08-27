//
//  FlexSideMenuAnimator+SubClass.h
//  Pods
//
//  Created by Boojapathy Chidambaram on 8/27/14.
//
//

#import "FlexSideMenuAnimator.h"

@interface FlexSideMenuAnimator (SubClass)
- (void)resetContentPosition:(UIView *)view;

- (void)resetSidebarPosition:(UIView *)view;

- (CGFloat)menuWidth;
@end
