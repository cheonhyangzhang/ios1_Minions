//
//  RootViewController.h
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSNumber *index;
@property (strong, nonatomic) id mystoryboard;
- (id)initWithIndex: (NSNumber *)number andWithStoryboard: (UIStoryboard *)sb;
- (id)init;
@end
