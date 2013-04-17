//
//  RootViewController.m
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import "RootViewController.h"

#import "ModelController.h"
#import "PageDetailViewController.h"

#import "DataViewController.h"

@interface RootViewController ()
@property (readonly, strong, nonatomic) ModelController *modelController;
@end

@implementation RootViewController

@synthesize modelController = _modelController;

- (id)initWithIndex: (NSNumber *)number andWithStoryboard: (UIStoryboard *)sb{
    self.index = number;
    self.mystoryboard = sb;
    NSLog(@"initWith... storyboard is: %@",self.mystoryboard);
    return self;
}
- (id)init{
    self.index = [[NSNumber alloc] initWithInt:0];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    // generate a new pageViewController
    self.pageViewController.delegate = self;
    // implement the delegate method in this file
    
    //load the first pageDetailViewController
    PageDetailViewController *startingViewController = [self.modelController viewControllerAtIndex: [self.index integerValue]];
    
    NSArray *viewControllers = @[startingViewController];
    // viewControllers are all the pages
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

    self.pageViewController.dataSource = self.modelController;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    pageViewRect = CGRectInset(pageViewRect, 0,0);
    self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModelController *)modelController
{
    NSLog(@"modelController");
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    
    
    if ([self storyboard]){
        NSLog(@"[self storyboard] is : %@", [self storyboard]);
        self.mystoryboard = [self storyboard];
    }
    
    
    if (!_modelController) {
        NSLog(@"Init the modelController and the storyboard is %@", self.mystoryboard);
        _modelController = [[ModelController alloc] initWithStoryboard:self.mystoryboard];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
        //Because only landscape is enabled in this app
        //So no need to conisder if we are in portrait mode
    
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
   
}

@end
