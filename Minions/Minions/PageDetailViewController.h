//
//  PageDetailViewController.h
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PageDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *tipTap;
@property (weak, nonatomic) IBOutlet UIView *clickableCharacter1;
@property (weak, nonatomic) IBOutlet UIView *clickableCharacter2;
- (id)initWithStoryboard:(UIStoryboard *) sb;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
- (IBAction)readToMe:(id)sender;
- (IBAction)goToHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *readToMeButton;
@property (weak, nonatomic) IBOutlet UIImageView *staticBackground;
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) id mystoryboard;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (strong,nonatomic) AVAudioPlayer *audioPlayer;
@property (strong,nonatomic) AVAudioPlayer *clickPlayer;
@property (strong, nonatomic) NSDictionary *tmpDic;
@property (strong, nonatomic) NSMutableArray *imageArray;
@end
