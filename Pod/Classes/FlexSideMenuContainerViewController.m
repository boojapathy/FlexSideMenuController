//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import "FlexSideMenuContainerViewController.h"
#import "FlexSideMenu.h"


@implementation FlexSideMenuContainerViewController
- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController menuPosition:(enum FlexMenuPosition) menuSide {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -2000;
    //    CATransform3D rotateTransform = CATransform3DIdentity;
    //    rotateTransform.m34 = 1.0 / -1000;
    //
    //    rotateTransform = CATransform3DRotate(rotateTransform, -45.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
    //    contentView.layer.transform = rotateTransform;
    containedViewController.view.layer.sublayerTransform = transform;
    
    self = [super initWithContainedViewController:containedViewController];
    if (self) {
        self.menuSide = menuSide;
    }
    return self;
}
@end