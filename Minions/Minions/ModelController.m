//
//  ModelController.m
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import "ModelController.h"
#import "PageDetailViewController.h"
#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation ModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.  
        NSString *plistPathExtra = [[NSBundle mainBundle] pathForResource:@"script" ofType:@"plist"];
        _pageData = [[NSArray alloc] initWithContentsOfFile:plistPathExtra];    
    }
    return self;
}
-(id)initWithStoryboard:(UIStoryboard *)sb{
    
    NSString *plistPathExtra = [[NSBundle mainBundle] pathForResource:@"script" ofType:@"plist"];
    _pageData = [[NSArray alloc] initWithContentsOfFile:plistPathExtra];
    self.mystoryboard = sb;
    return self;
}

- (PageDetailViewController *)viewControllerAtIndex:(NSUInteger)index
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }    
    PageDetailViewController *dataViewController = [[PageDetailViewController alloc] initWithStoryboard:self.mystoryboard];
    
    dataViewController.dataObject = self.pageData[index];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *bookmark = [defaults objectForKey:@"bookmark"];
    if (!bookmark)
        bookmark = [[NSNumber alloc]init];
    bookmark = [[NSNumber alloc] initWithInt:index];
//    NSDictionary *abridgedTweet = @{@"Page" : [[NSNumber alloc] initWithInt: index]};
//    [bookmark addObject:abridgedTweet];
    
    // Reset the FavoritesTweet array
    [defaults setObject:bookmark forKey:@"bookmark"];
    [defaults synchronize];
    //NSLog(@"Userdefault is :%@", [defaults dictionaryRepresentation]);

    return dataViewController;
}
  

//- (NSUInteger)indexOfViewController:(DataViewController *)viewController
//{   
//     // Return the index of the given data view controller.
//     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
//    return [self.pageData indexOfObject:viewController.dataObject];
//}
- (NSUInteger)indexOfViewController:(PageDetailViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source
//the two methods down are called when user switch page

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"BeforeViewController");
    NSUInteger index = [self indexOfViewController:(PageDetailViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
     NSLog(@"AfterViewController");
    NSUInteger index = [self indexOfViewController:(PageDetailViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
//    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
    return [self viewControllerAtIndex:index];
}

@end
