//
//  HomeViewController.m
//  Minions
//  All is done
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import "HomeViewController.h"
#import "PageDetailViewController.h"
#import "RootViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:( NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.indexlight = 0;
    NSLog(@"Home viewDidLoad");
    [super viewDidLoad];
    self.theLight.userInteractionEnabled = YES;
    [self addGestureRecognizersToOrnament:self.theLight];
}
- (void)viewDidAppear:(BOOL)animated{    
    [self startAnimation];
}

- (void)startAnimation{
    self.theHint.hidden = YES;
    self.theLight.center = CGPointMake(429+90, -6-150);
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                        self.theLight.center = CGPointMake(429+90, -6+180);
                     }
                     completion:^(BOOL completed){
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              self.theLight.center = CGPointMake(429+90, -6+90);
                                              NSLog(@"2");
                                          }
                                          completion:^(BOOL completed){
                                              
                                              [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   NSLog(@"3");
                                                                   self.theLight.center = CGPointMake(429+90, -6+150);
                                                               }
                                                               completion:^(BOOL completed){
                                                                    //Final animation has ended
                                                                   self.theHint.hidden = NO;
                                                               }];
                    }];
    }];
    
    [self performSelector:@selector(dismissHint) withObject:nil afterDelay:4.0];
}
- (void)dismissHint{
    self.theHint.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) addGestureRecognizersToOrnament:(UIView *) piece
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPiece:)];
//    [tapGesture setDelegate:self];
//    [piece addGestureRecognizer:tapGesture];
}

//-(void) tapPiece:(UITapGestureRecognizer *) gestureRecognizer{
//    self.indexlight = (self.indexlight + 1) % 3;
//    NSString *thelocation = [[NSString alloc] initWithFormat:@"light%d",self.indexlight ];
//    NSLog(@"The location is %@", thelocation);
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource: thelocation  ofType:@"png"];
//    NSLog(@"The path is %@",imagePath);
//    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
//    self.theLight.image = image;
//}
-(void) panPiece:(UIPanGestureRecognizer *) gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    [[piece superview] bringSubviewToFront:piece];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged)// this may be wrong seond
    {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}


#pragma mark - Shake Detection
- (BOOL) canBecomeFirstResponder{
    return YES;
}



@end
