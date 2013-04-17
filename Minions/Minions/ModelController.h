//
//  ModelController.h
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class DataViewController;
@class PageDetailViewController;
@interface ModelController : NSObject <UIPageViewControllerDataSource>
@property (strong, nonatomic) id mystoryboard;
- (PageDetailViewController *)viewControllerAtIndex:(NSUInteger)index;
-(id)initWithStoryboard:(UIStoryboard *)sb;
- (NSUInteger)indexOfViewController:(PageDetailViewController *)viewController;

@end
