//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import "FlexContainerViewController.h"


@implementation FlexContainerViewController
- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController {
    self = [super init];
    if (self) {
        self.containedViewController = containedViewController;
    }
    return self;
}

- (void)setContentController:(UIViewController *)contentController {
    if(self.containedViewController) {
        [self.containedViewController willMoveToParentViewController:nil];
        [self.containedViewController.view removeFromSuperview];
        [self.containedViewController removeFromParentViewController];
    }
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
    [contentController didMoveToParentViewController:self];

    self.containedViewController = contentController;
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    if(self.containedViewController) {
        [self addChildViewController:self.containedViewController];
        [self.view addSubview:self.containedViewController.view];
        [self.containedViewController didMoveToParentViewController:self];
    }
}

- (void)hideView {
    self.view.hidden = YES;
}

- (void)showView {
    self.view.hidden = NO;
}

@end
