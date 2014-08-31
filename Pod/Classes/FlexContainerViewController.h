//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FlexContainerViewController : UIViewController
@property (nonatomic, strong) UIViewController *containedViewController;

- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController;

- (void)hideView;

- (void)showView;

- (void)setContentController:(UIViewController *)contentController;
@end
