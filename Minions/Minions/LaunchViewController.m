//
//  LaunchViewController.m
//  Minions
//
//  Created by cheonhyang on 13-4-14.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import "LaunchViewController.h"
#import "HomeViewController.h"
#import "RootViewController.h"

//this viewController is used to deal with bookmark

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)checkBookmark{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *bookmark = [defaults objectForKey:@"bookmark"];
    if (bookmark){
        //if bookmark is not nil   goto certain page that bookmark indicates
        //NSLog(@"Go to certain page %d", [bookmark integerValue]);

        //Generate RootViewController to go to certain page
        //since RootViewController needs storyboard so storyboard is needed as argument
        RootViewController *rvc = [[RootViewController alloc] initWithIndex:bookmark andWithStoryboard:[self storyboard]];
        [self presentViewController:rvc animated:NO completion:nil];
    }
    else{
        //if no bookmark exists  just show the home page of the page
        HomeViewController *hvc = [[self storyboard] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:hvc animated:NO completion:^{}];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"LaunchViewContgroller");
	// Do any additional setup after loading the view.    
}
- (void)viewDidAppear:(BOOL)animated{
    //show certain viewController using checkBookmark method
    [self checkBookmark];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
