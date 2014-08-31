//
//  FlexSideMenuAnimator+SubClass.m
//  Pods
//
//  Created by Boojapathy Chidambaram on 8/27/14.
//
//

#import "FlexSideMenuAnimator+SubClass.h"

@implementation FlexSideMenuAnimator (SubClass)
- (void)resetContentPosition:(UIView *)view {
    [self resetViewPosition:view];
    
    [view.superview bringSubviewToFront:view];
    view.layer.zPosition = 0;
}

- (void)resetSidebarPosition:(UIView *)view {
    [self resetViewPosition:view];
    
    [view.superview sendSubviewToBack:view];
    view.layer.zPosition = 0;
}

- (CGFloat) menuWidth {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    return (screenWidth - screenWidth/8);
}

- (CGFloat) degreeToRadians:(CGFloat)degrees {
    return (CGFloat) (degrees * M_PI / 180.0f);
}


- (void)resetViewPosition:(UIView *)view {
    CATransform3D resetTransform = CATransform3DIdentity;
    resetTransform = CATransform3DRotate(resetTransform, [self degreeToRadians:0], 1, 1, 1);
    resetTransform = CATransform3DScale(resetTransform, 1.0, 1.0, 1.0);
    resetTransform = CATransform3DTranslate(resetTransform, 0.0, 0.0, 0.0);
    view.layer.transform = resetTransform;
    
    CGRect resetFrame = view.frame;
    resetFrame.origin.x = 0;
    resetFrame.origin.y = 0;
    view.frame = resetFrame;
}
@end
