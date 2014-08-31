//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import "FlexSideMenuContainerViewController.h"
#import "FlexSideMenu.h"


@implementation FlexSideMenuContainerViewController
- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController menuPosition:(enum FlexMenuPosition) menuSide {
    self = [super initWithContainedViewController:containedViewController];
    if (self) {
        self.menuSide = menuSide;
    }
    return self;
}
@end
