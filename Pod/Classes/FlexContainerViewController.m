//
// Created by Boojapathy Chidambaram on 8/27/14.
//

#import "FlexContainerViewController.h"


@implementation FlexContainerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithContainedViewController:(UIViewController *)containedViewController {
    self = [super init];
    if (self) {
        self.containedViewController = containedViewController;
    }
    return self;
}

- (void)addViewControllerToContainer {
    NSAssert(self.containedViewController != nil, @"contentViewController was not set");
    if(self.containedViewController) {
        [self addChildViewController:self.containedViewController];
        [self.view addSubview:self.containedViewController.view];
        [self.containedViewController didMoveToParentViewController:self];
    }
}

- (void)hideView {
    self.view.hidden = NO;
}

- (void)showView {
    self.view.hidden = YES;
}

@end