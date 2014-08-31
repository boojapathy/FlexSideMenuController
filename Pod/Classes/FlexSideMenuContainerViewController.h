//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <Foundation/Foundation.h>
#import "FlexContainerViewController.h"


@interface FlexSideMenuContainerViewController : FlexContainerViewController
@property enum FlexMenuPosition menuSide;

- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController menuPosition:(enum FlexMenuPosition)menuSide;
@end
