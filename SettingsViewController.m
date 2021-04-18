//
//  SettingsViewController.m
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 30/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "SettingsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MenuViewController.h"
#import "ViewController.h"
#import "InstructionsViewController.h"

@interface SettingsViewController ()
{
    AVAudioPlayer *MenuMusic;
}
@end

@implementation SettingsViewController

@synthesize setName;

- (void)viewDidLoad {
    // Set up URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/melodyloops-adrenaline.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Created an audio player object and initialized with URL to sound
    MenuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    if ([self.musicStatetoPass isEqualToString:@"On"]) {
        NSLog(@"Music in settings is On");
        [MenuMusic play];
    }
    else {
        NSLog(@"Music in settings is Off");
        [MenuMusic stop];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Data Transfer
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"compare score = %ld", (long)_compareScore);
    NSLog(@"compare score = %ld", (long)_highScore);

    if (_compareScore > _highScore) {
        self.highScore = self.compareScore;
        self.highScoreName = self.compareScoreName;
        
        NSString *abcd = [[NSUserDefaults standardUserDefaults] stringForKey:@"keyHighName"];
        self.highScoreName = abcd;
        NSString *textWithinField = self.compareScoreName;
        [[NSUserDefaults standardUserDefaults]setObject:textWithinField forKey:@"keyHighName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSInteger dcba = [[NSUserDefaults standardUserDefaults] integerForKey:@"keyHighScore"];
        self.highScore = dcba;
        NSInteger numberWithinField = self.compareScore;
        [[NSUserDefaults standardUserDefaults]setInteger:numberWithinField forKey:@"keyHighScore"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        self.highscoreSetbyValueX = [NSString stringWithFormat:@"%@ = %lu", self.highScoreName, ( long)self.highScore] ;
        
        NSString *abcde = [[NSUserDefaults standardUserDefaults] stringForKey:@"finalSet"];
        self.highScoreSetbyValue.text = abcde;
        NSString *finalSetDone = self.highscoreSetbyValueX;
        [[NSUserDefaults standardUserDefaults]setObject:finalSetDone forKey:@"finalSet"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    NSString *stringKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"ourTextKey"];
    self.enterName.text = stringKey;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.setName = self.enterName.text;
    NSLog(@"Name set button pressed = %@", self.setName);
    
    NSString *textWithinField = _enterName.text ;
    [[NSUserDefaults standardUserDefaults]setObject:textWithinField forKey:@"ourTextKey"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (_compareScore > _highScore) {
        self.highScore = self.compareScore;
        self.highScoreName = self.compareScoreName;
        
        NSString *abcd = [[NSUserDefaults standardUserDefaults] stringForKey:@"keyHighName"];
        self.highScoreName = abcd;
        NSString *textWithinField = self.compareScoreName;
        [[NSUserDefaults standardUserDefaults]setObject:textWithinField forKey:@"keyHighName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSInteger dcba = [[NSUserDefaults standardUserDefaults] integerForKey:@"keyHighScore"];
        self.highScore = dcba;
        NSInteger numberWithinField = self.compareScore;
        [[NSUserDefaults standardUserDefaults]setInteger:numberWithinField forKey:@"keyHighScore"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        self.highscoreSetbyValueX = [NSString stringWithFormat:@"%@ = %lu", self.highScoreName, ( long)self.highScore] ;
        
        NSString *abcde = [[NSUserDefaults standardUserDefaults] stringForKey:@"finalSet"];
        self.highScoreSetbyValue.text = abcde;
        NSString *finalSetDone = self.highscoreSetbyValueX;
        [[NSUserDefaults standardUserDefaults]setObject:finalSetDone forKey:@"finalSet"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backButton"]){
        MenuViewController *Controller = (MenuViewController *)segue.destinationViewController;
        Controller.userName= self.setName;
        NSLog(@"Name state in settings = %@",self.setName);
        NSLog(@"Name sent to menu = %@",Controller.userName);
    }
}

// Action which saves the name once the button is pressed
- (IBAction)saveName:(UIButton *)sender {
    self.setName = self.enterName.text;
    NSLog(@"Name set button pressed = %@", self.setName);
}

- (IBAction)BackButtonPressed:(UIButton *)sender {
     [MenuMusic stop];
}

#pragma mark Text Field Delegate Method
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if ([self.enterName isFirstResponder]) {
        [self.enterName resignFirstResponder];
    }
    
    return YES;
    // Removes keyboard from view when we press return
}

- (IBAction)RemoveKeyboard:(UIControl *)sender {
    // Allows keyboard to be removed after we click background. UIView is changed to UIControl. Create IBAction and set event to touchupinside.
    
    NSLog(@"Background Pressed");
    if ([self.enterName isFirstResponder]) {
        [self.enterName resignFirstResponder];
    }
}

#pragma mark State of music
// Set the state for the music within the view.
- (IBAction)musicState:(UISwitch *)sender {
    if (sender.on) {
        [MenuMusic play];
        self.musicState.text = [NSString stringWithFormat:@"Music State: On"];
        self.musicStatetoPass = [NSString stringWithFormat:@"On"];
        NSLog(@"Music state button is %@", self.musicStatetoPass);
    }
    
    else {
        [MenuMusic stop];
        self.musicState.text = [NSString stringWithFormat:@"Music State: Off"];
        self.musicStatetoPass = [NSString stringWithFormat:@"Off"];
        NSLog(@"Music state button is %@", self.musicStatetoPass);
    }
}
@end
