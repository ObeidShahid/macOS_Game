//
//  InstructionsViewController.m
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 05/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "InstructionsViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface InstructionsViewController ()
{
    AVAudioPlayer *MenuMusic;
}
@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    // set up URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/melodyloops-adrenaline.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Created an audio player object and initialized with URL to sound
    MenuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    if ((self.placeholderSwitchState4 = @"On")) {
        NSLog(@"The music in instructions is On");
        [MenuMusic play];
        
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Ends music when the user goes back
- (IBAction)BackButton:(UIButton *)sender {
    [MenuMusic stop];
}
@end
