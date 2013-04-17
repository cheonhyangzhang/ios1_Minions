//
//  HomeViewController.h
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *theHint;
@property (weak, nonatomic) IBOutlet UIImageView *theLight;
@property (strong, nonatomic) NSMutableArray * thelightsimage;
@property int indexlight;
@end
