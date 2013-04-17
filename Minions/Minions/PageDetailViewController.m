//
//  PageDetailViewController.m
//  Minions
//
//  Created by cheonhyang on 13-4-11.
//  Copyright (c) 2013年 Tianxiang Zhang. All rights reserved.
//

#import "PageDetailViewController.h"
#import "HomeViewController.h"

@interface PageDetailViewController ()

@end

@implementation PageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithStoryboard:(UIStoryboard *) sb{
    NSLog(@"Initwithstoryboard");
    self.mystoryboard = sb;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"PageDetailView loaded");
   
    self.tmpDic = [NSDictionary dictionaryWithDictionary:self.dataObject];//now page infor
    self.dataLabel.text = [self.tmpDic objectForKey:@"readScript"];
    
    UITapGestureRecognizer *characterTapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(characterTap:)];
    UITapGestureRecognizer *characterTapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(characterTap:)];
    [self.clickableCharacter1 addGestureRecognizer:characterTapGesture1];
    [self.clickableCharacter2 addGestureRecognizer:characterTapGesture2];
    self.clickableCharacter1.userInteractionEnabled = YES;
    self.clickableCharacter2.userInteractionEnabled = YES;
    BOOL clickableCharacter = [[self.tmpDic objectForKey:@"clickable"] boolValue];
    self.tipTap.hidden = !clickableCharacter;
    if (clickableCharacter == YES){
        int type = [[self.tmpDic objectForKey:@"touchnum"] integerValue];
        if (type ==1){
            self.clickableCharacter1.hidden = NO;
            self.clickableCharacter2.hidden = YES;
        }
        else if (type ==2){
            
            self.clickableCharacter1.hidden = YES;
            self.clickableCharacter2.hidden = NO;
        } 
    }
    else{
        self.clickableCharacter1.hidden = YES;
        self.clickableCharacter2.hidden = YES;
    }
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
    [self loadImages];
    [self loadSound];
    [self showScriptAndPlaySound];   
}

- (void)characterTap: (UITapGestureRecognizer *)gesture{
    [self startAnimation];
    [self.clickPlayer prepareToPlay];
    [self.clickPlayer play];
}

#pragma mark - load information from file
- (void)loadImages{
    NSArray *imagePaths = [self.tmpDic objectForKey:@"imagePath"];
    self.imageArray = [[NSMutableArray alloc] init];
    for (int i=0; i< [imagePaths count]; i++){
        NSString *imagePath = [[NSBundle mainBundle] pathForResource: [imagePaths objectAtIndex:i]  ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        [self.imageArray addObject:image];
    }
    
    self.background.animationImages = self.imageArray;
    self.background.animationRepeatCount = 1;
    self.background.animationDuration = 2.0f;
    self.staticBackground.image = [self.imageArray objectAtIndex:0];
}
- (void)loadSound{
    NSString *soundPath = [[NSBundle mainBundle] pathForResource: [self.tmpDic objectForKey:@"readSoundPath" ] ofType:@"aiff"];
    NSURL *url = [NSURL fileURLWithPath:soundPath];
    //NSLog(@"The url is %@",url);
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error:&error];
    
    
    
    NSString *tmpsoundPath = [[NSBundle mainBundle] pathForResource: [self.tmpDic objectForKey:@"soundPath" ] ofType:@"aiff"];
    NSLog(@"The soundPath is %@",tmpsoundPath);
    NSURL *tmpurl = [NSURL fileURLWithPath:tmpsoundPath];
    NSLog(@"The tmpurl is %@",tmpurl);
    self.clickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: tmpurl error:&error];
}
- (void)loadScript{
    //self.readToMeButton.userInteractionEnabled = NO;
    NSArray *theRangeArray = [self.tmpDic objectForKey:@"scriptRange"];
    for (int i = 0 ; i < [theRangeArray count]; i++){
        NSDictionary *theTimeRange = [theRangeArray objectAtIndex:i];
        [self performSelector:@selector(updateScript:) withObject:theTimeRange afterDelay:[[theTimeRange objectForKey:@"start"] doubleValue] ];
    }
    NSDictionary *theLastRange = [theRangeArray objectAtIndex:([theRangeArray count]-1)];
    double resetTime = [[theLastRange objectForKey:@"end"] doubleValue];
    //NSLog(@"the reset time is : %f",resetTime);
    [self performSelector:@selector(resetScript) withObject:nil afterDelay:resetTime];    
    [self performSelector:@selector(startAnimation) withObject:self afterDelay:resetTime];
    [self performSelector:@selector(enableReadToMe) withObject:nil afterDelay:resetTime];
    [self performSelector:@selector(setBackgroundAfterAnimation) withObject:self afterDelay:resetTime+2.0f];
}
- (void)playSound{
    self.readToMeButton.hidden = YES;
    if (self.audioPlayer == nil){
        NSLog(@"The audio is nil");
    }
    else{
        NSLog(@"The audio is OK");
       [self.audioPlayer stop];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

- (void)resetScript{
    NSLog(@"resetScript called");
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:[self.tmpDic objectForKey:@"readScript"]];
    UIColor *black= [UIColor blackColor];
     UIFont *font = [UIFont fontWithName:@"Chalkduster" size: 25.0f];
    [attrString addAttribute:NSForegroundColorAttributeName value:black range:NSMakeRange(0, [attrString length])];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [attrString length])];

    self.dataLabel.attributedText= attrString;
}
- (void)updateScript:(NSDictionary*)withRange{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:[self.tmpDic objectForKey:@"readScript"]];
    UIColor *yellow= [UIColor yellowColor];
    UIFont *font = [UIFont fontWithName:@"Chalkduster" size: 40.0f];
    [attrString addAttribute:NSForegroundColorAttributeName value:yellow range:NSMakeRange([[withRange objectForKey:@"left"] doubleValue], [[withRange objectForKey:@"length"] doubleValue])];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange([[withRange objectForKey:@"left"] doubleValue], [[withRange objectForKey:@"length"] doubleValue])];    
    self.dataLabel.attributedText= attrString;
}


- (void)showScriptAndPlaySound{
    [self playSound];
    [self loadScript];
}
- (void)setBackgroundAfterAnimation{
     self.staticBackground.image = [self.imageArray objectAtIndex:([self.imageArray count] - 1)];     
}
- (void)enableReadToMe{
    self.readToMeButton.hidden = NO;
}

- (void)startAnimation{
    [self.background startAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readToMe:(id)sender {
    [self showScriptAndPlaySound];    
}

- (IBAction)goToHome:(id)sender {
    HomeViewController *hvc = [(UIStoryboard *)self.mystoryboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    NSLog(@"The hmvc: %@",hvc);
    NSLog(@"The storyboard is :%@",self.mystoryboard);
    [self presentViewController:hvc animated:NO completion:^{NSLog(@"Go to home");}];
}
@end
