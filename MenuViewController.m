//
//  MenuViewController.m
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 29/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "MenuViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SettingsViewController.h"
#import "ViewController.h"
@interface MenuViewController ()

{
    AVAudioPlayer *MenuMusic;
}

@end

@implementation MenuViewController
@synthesize placeholderSwitchState;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SwitchStateLabel.hidden = true;
    NSLog(@"Value passed down to menu is %@",self.placeholderSwitchState);
    
    // Set up URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/melodyloops-adrenaline.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
        
    // Created an audio player object and initialized with URL to sound
    MenuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    //Determines state of music depending on what is being sent.
    if ((self.placeholderSwitchState = @"On")) {
       NSLog(@"The switch state recieved in menu is %@" , self.placeholderSwitchState);
       [MenuMusic play];
    }
    
   else if ((self.placeholderSwitchState = @"Off")) {
        NSLog(@"The switch state recieved in menu is %@" , self.placeholderSwitchState);
        [MenuMusic stop];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"passNameToGame"]){
        ViewController *Controller = (ViewController *)segue.destinationViewController;
        Controller.currentName= self.userName;
        NSLog(@"Name state in menu before send = %@",self.userName);
        NSLog(@"Name sent to game = %@",Controller.currentName);
    }
    
    if ([segue.identifier isEqualToString:@"passBackData"]){
        SettingsViewController *Controller = (SettingsViewController *)segue.destinationViewController;
        Controller.compareScoreName= self.userName2;
        NSLog(@"Name state in menu before send = %@",self.userName2);
        NSLog(@"Name sent to settings = %@",Controller.compareScoreName);
        Controller.compareScore= self.userScore;
        NSLog(@"Score state in menu = %ld",self.userScore);
        NSLog(@"Score sent to settings = %ld",Controller.compareScore);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Ends the music when i change between views within my game
- (IBAction)StartGamePressed:(UIButton *)sender {
    [MenuMusic stop];
}

- (IBAction)InstructionsPrssed:(UIButton *)sender {
     [MenuMusic stop];
}

- (IBAction)SettingsPressed:(UIButton *)sender {
     [MenuMusic stop];
}
@end
