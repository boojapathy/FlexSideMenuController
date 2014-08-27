//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FlexContainerViewController : UIViewController
@property (assign) UIViewController *containedViewController;

- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController;

- (void)addViewControllerToContainer;

- (void)hideView;

- (void)showView;
@end