//
//  ViewController.m
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SettingsViewController.h"
#import "MenuViewController.h"
@interface ViewController ()

{
    AVAudioPlayer *MenuMusic;
}

@end

// Declaring integers to be used within code
int Chanceofattack;
float bunnySpeed;
int randomSpeed;
int score;

@implementation ViewController

// synthesized the playerName to be used within the view
@synthesize playerName;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setting a value from my DataShared model with a string in the game view
    NSLog(@"Name set in game = %@", self.currentName);
    
    // Set up a URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/melodyloops-adrenaline.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Created an audio player object and initialized with URL to sound
    MenuMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    if ((self.placeholderSwitchState2 = @"On")) {
        NSLog(@"Placeholder switch state is On");
        [MenuMusic play];
    }
    
    // Displays the elements needed for the game when we press start. In turn the menu will be hidden.
    self.FistAttack.hidden = true;
    self.HealthBar.hidden = false;
    self.Score.hidden = false;
    self.Healthlabel.hidden = false;
    self.BorgBunnySprite.hidden = false;
    self.RoadmanShaq.hidden = false;
    self.AttackbuttonX.hidden = false;
    self.egg1.hidden = false;
    self.egg2.hidden = false;
    self.egg3.hidden = false;
    self.egg4.hidden = false;
    self.gameover.hidden = true;
    self.endgameQuit.hidden = true;
    self.endgameScore.hidden = true;
    self.endgameReplay.hidden = true;
    self.congratsName.hidden = true;
    
    // Set the original value for score/health and using a string to display this.
    score = 0;
    self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    NSLog(@"Score in viewDidLoad = %d", score);
    self.HealthBar.progress = 1;
    
    // Setting the original positions for the sprites for when the game will load.
    self.RoadmanShaq.center = CGPointMake(50, 350);
    self.BorgBunnySprite.center = CGPointMake(785, 350);
    self.FistAttack.center = CGPointMake(self.RoadmanShaq.center.x, self.RoadmanShaq.center.y);
    self.Fireball.center = CGPointMake(self.BorgBunnySprite.center.x, self.BorgBunnySprite.center.y);
    self.egg1.center = CGPointMake(100, -20);
    self.egg2.center = CGPointMake(300, -40);
    self.egg3.center = CGPointMake(500, -60);
    self.egg4.center = CGPointMake(200, -80);
    
    // Starting the methods/timers for my enemy/falling objects
    [self bunnyPosition];
    self.eggMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(eggMovement) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Code regarding games navigation.

- (IBAction)StartGame:(UIButton *)sender {
}

- (IBAction)endgameReplayc:(UIButton *)sender {
    // Restarts the game code
    /*
    // Displays the elements needed for the game when we press start. In turn the menu will be hidden.
    
    self.FistAttack.hidden = true;
    self.HealthBar.hidden = false;
    self.Score.hidden = false;
    self.Healthlabel.hidden = false;
    self.BorgBunnySprite.hidden = false;
    self.RoadmanShaq.hidden = false;
    self.AttackbuttonX.hidden = false;
    self.egg1.hidden = false;
    self.egg2.hidden = false;
    self.egg3.hidden = false;
    self.egg4.hidden = false;
    self.gameover.hidden = true;
    self.endgameQuit.hidden = true;
    self.endgameScore.hidden = true;
    self.endgameReplay.hidden = true;
    // Set the original value for score/health and using a string to display this.
    score = 0;
    
    self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    self.HealthBar.progress = 1;
    
    // Setting the original positions for the sprites for when the game will load.
    
    self.RoadmanShaq.center = CGPointMake(50, 350);
    self.BorgBunnySprite.center = CGPointMake(770, 350);
    self.FistAttack.center = CGPointMake(self.RoadmanShaq.center.x, self.RoadmanShaq.center.y);
    self.Fireball.center = CGPointMake(self.BorgBunnySprite.center.x, self.BorgBunnySprite.center.y);
    self.egg1.center = CGPointMake(200, -20);
    self.egg2.center = CGPointMake(300, -20);
    self.egg3.center = CGPointMake(400, -20);
    self.egg4.center = CGPointMake(500, -20);
    
    [self bunnyPosition];
    
    self.eggMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(eggMovement) userInfo:nil repeats:YES];*/

    // Waits for a second before the game will initilise replay
    
    [self performSelector:@selector(ReplayGame) withObject:nil afterDelay:1];
    [self ReplayGame];
}


- (IBAction)endgameQuit:(UIButton *)sender {
    [MenuMusic stop];
}

#pragma mark Code regarding the users movements

// Created two void functions to allow the position of the user to move 5 spaces left or right.
-(void)userLeft {
    // Sprite would move left 5 pixels if function called.
    self.RoadmanShaq.center = CGPointMake(self.RoadmanShaq.center.x - 5, self.RoadmanShaq.center.y);
    
    // If the sprite clashes with the border it will keep the user within limits
    if (CGRectIntersectsRect(self.RoadmanShaq.frame, self.leftBorder.frame)) {
        self.RoadmanShaq.center = CGPointMake(15, 350);
    }
}

// Calls up the void function depending on what action we do.
- (IBAction)userMoveLeft:(UIButton *)sender {
    // Repeats the fuction in the selector in intervals which I select. This activates when we hold down the button.
    self.leftTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(userLeft) userInfo:nil repeats:YES];
    if (self.leftTimer == nil) {
        self.leftTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(userLeft) userInfo:nil repeats:YES];
    }
}

// Stops the timer which stops the user moving. This activates when we user releases his hand, which acts as a touch up inside.
- (IBAction)userStopLeft:(UIButton *)sender {
    [self.leftTimer invalidate];
    self.leftTimer = nil;
}

//Stops the timer which stops the user moving. This activates when the user drags off the button.
- (IBAction)userDragStopLeft:(UIButton *)sender {
    [self.leftTimer invalidate];
    self.leftTimer = nil;
}


-(void)userRight {
    // Sprite would move right 5 pixels if function called.
    self.RoadmanShaq.center = CGPointMake(self.RoadmanShaq.center.x + 5, self.RoadmanShaq.center.y);
    
    // If the sprite clashes with the border it will keep the user within limits
    if (CGRectIntersectsRect(self.RoadmanShaq.frame, self.rightBorder.frame)) {
        self.RoadmanShaq.center = CGPointMake(625, 350);
    }
}

- (IBAction)userMoveRight:(UIButton *)sender {
    // Repeats the fuction in the selector in intervals which I select. This activates when we hold down the button.
    self.rightTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(userRight) userInfo:nil repeats:YES];
    if (self.rightTimer == nil) {
        self.rightTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(userRight) userInfo:nil repeats:YES];
    }
}

// Stops the timer which stops the user moving. This activates when we user releases his hand, which acts as a touch up inside.
- (IBAction)userStopRight:(UIButton *)sender {
    [self.rightTimer invalidate];
     self.rightTimer = nil;
}

//Stops the timer which stops the user moving. This activates when the user drags off the button.
- (IBAction)userDragStopRight:(UIButton *)sender {
    [self.rightTimer invalidate];
     self.rightTimer = nil;
}

#pragma mark Code regarding the users attack

// Method for the attack button to launch a projectile attack.

- (IBAction)AttackButton:(UIButton *)sender {
    // Cancels the previous attack and resets the position of the attack sprite.
    [self.fistattackMovementTimer invalidate];
    self.FistAttack.hidden = false;
    self.FistAttack.center = CGPointMake(self.RoadmanShaq.center.x, self.RoadmanShaq.center.y);
    
    // Starts the attack again within the timer which repeats the selector for set interval.
    self.fistattackMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fistattackMovement) userInfo:nil repeats:YES];
}

// Code for the attacks movement
-(void)fistattackMovement {
    // Makes the attack sprite visable and moves right 10 pixels as code is called up.
    self.FistAttack.hidden = NO;
    self.FistAttack.center = CGPointMake(self.FistAttack.center.x + 10, self.FistAttack.center.y);

    // If the two sprites collide, the user will gain score
    if (CGRectIntersectsRect(self.FistAttack.frame, self.BorgBunnySprite.frame)) {
        score = score + 2;
        self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
        
        // Stops the movement of the projectile
        [self.fistattackMovementTimer invalidate];
        
        // Recenters the attack projectile back to the users sprite
        self.FistAttack.center = CGPointMake(self.RoadmanShaq.center.x, self.RoadmanShaq.center.y);
        self.FistAttack.hidden = true;
        
        //Stops the bunny from moving and then recenters for another attack
        [self.bunnyMovementTimer invalidate];
        [self bunnyPosition];
    }
    // if the attack sprite hits the borders it will stop, hide and then recenter.
    if (CGRectIntersectsRect(self.FistAttack.frame, self.rightBorder.frame)) {
        [self.fistattackMovementTimer invalidate];
        self.FistAttack.center = CGPointMake(self.RoadmanShaq.center.x, self.RoadmanShaq.center.y);
        self.FistAttack.hidden = true;
    }
}

#pragma mark Code regarding enemy

-(void)bunnyMovementTimerx {
    // Timer which repeats the bunny movement
    self.bunnyMovementTimer = [NSTimer scheduledTimerWithTimeInterval:bunnySpeed target:self selector:@selector(bunnyMovement) userInfo:nil repeats:YES];
}

-(void)bunnyPosition {
    // Resets the bunny position whenever the function is called.
    self.BorgBunnySprite.center = CGPointMake(770, 350);
  
    //Sets the speed that the bunny will attack
    randomSpeed = arc4random() % 3;
    switch (randomSpeed) {
        case 0:
            bunnySpeed = 0.03;
            break;
        case 1:
            bunnySpeed = 0.02;
            break;
        case 2:
            bunnySpeed = 0.01;
        default:
            break;
    }
    // Sets how quick new attacks will occur
    Chanceofattack = arc4random() % 5;
    [self performSelector:@selector(bunnyMovementTimerx) withObject:nil afterDelay:Chanceofattack];
}

-(void)bunnyMovement {
    self.BorgBunnySprite.center = CGPointMake(self.BorgBunnySprite.center.x - 1, self.BorgBunnySprite.center.y);
    
    // If a collision between the two sprites occur, health will be deducted.
    if (CGRectIntersectsRect(self.BorgBunnySprite.frame, self.RoadmanShaq.frame)) {
        self.HealthBar.progress = self.HealthBar.progress - 0.2;
        [self.bunnyMovementTimer invalidate];
    
        // If the user still has health left, the sprite will relocate for another attack and game will still be active
    if (self.HealthBar.progress > 0) {
        [self bunnyPosition];
    }
    // If the user has no health, the game will be over
    if (self.HealthBar.progress == 0) {
        [self GameOver];
    }
    }
    
    // If the bunny hits the left border, it will resets its position
    if (CGRectIntersectsRect(self.BorgBunnySprite.frame, self.leftBorder.frame)){
        [self bunnyPosition];
    }
}

#pragma mark Falling egg code

-(void)eggMovement {
    // Created random values for the eggs to start at
    NSInteger PosX;
    NSInteger PosY;
    
    PosX = (arc4random() %600)+15;
    NSLog(@"Position X is %ld", PosX);
    PosY = (int)arc4random_uniform(50)-150;
    NSLog(@"Position Y is %ld", PosY);
    
    // Set the speed at which the eggs will drop at
    self.egg1.center = CGPointMake(self.egg1.center.x, self.egg1.center.y +3);
    self.egg2.center = CGPointMake(self.egg2.center.x, self.egg2.center.y +3);
    self.egg3.center = CGPointMake(self.egg3.center.x, self.egg3.center.y +3);
    self.egg4.center = CGPointMake(self.egg4.center.x, self.egg4.center.y +3);
    
    // if the eggs collide with the bottom border, the egg will recenter and update the score.
    if (CGRectIntersectsRect(self.egg1.frame, self.bottomBorder.frame)){
        self.egg1.center = CGPointMake(PosX, PosY);
        score = score +1;
        self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    }
    if (CGRectIntersectsRect(self.egg2.frame, self.bottomBorder.frame)){
        self.egg2.center = CGPointMake(PosX, PosY);
        score = score +1;
        self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    }
    if (CGRectIntersectsRect(self.egg3.frame, self.bottomBorder.frame)){
        self.egg3.center = CGPointMake(PosX, PosY);
        score = score +1;
        self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    }
    if (CGRectIntersectsRect(self.egg4.frame, self.bottomBorder.frame)){
        self.egg4.center = CGPointMake(PosX, PosY);
        score = score +1;
        self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    }
    
    // If the egg collides with the users sprite, the egg will recenter and cause the health to decrease by 0.1.
    if (CGRectIntersectsRect(self.egg1.frame, self.RoadmanShaq.frame)){
        self.egg1.center = CGPointMake(PosX, PosY);
        self.HealthBar.progress = self.HealthBar.progress - 0.1;
        
        // Ends the game if the users health is 0
        if (self.HealthBar.progress == 0) {
            [self GameOver];
        }
    }
    if (CGRectIntersectsRect(self.egg2.frame, self.RoadmanShaq.frame)){
        self.egg2.center = CGPointMake(PosX, PosY);
        self.HealthBar.progress = self.HealthBar.progress - 0.1;
        if (self.HealthBar.progress == 0) {
            [self GameOver];
        }
    }
    if (CGRectIntersectsRect(self.egg3.frame, self.RoadmanShaq.frame)){
        self.egg3.center = CGPointMake(PosX, PosY);
        self.HealthBar.progress = self.HealthBar.progress - 0.1;
        if (self.HealthBar.progress == 0) {
            [self GameOver];
        }
    }
    if (CGRectIntersectsRect(self.egg4.frame, self.RoadmanShaq.frame)){
        self.egg4.center = CGPointMake(PosX, PosY);
        self.HealthBar.progress = self.HealthBar.progress - 0.1;
        if (self.HealthBar.progress == 0) {
            [self GameOver];
        }
    }
}

#pragma mark Game Over Code
// Function to be called when game ends.
-(void)GameOver {
    NSLog(@"Name set in game = %@", self.playerName);
    
    // stops the movement for projectiles and enemies
    [self.bunnyMovementTimer invalidate];
    [self.fistattackMovementTimer invalidate];
    [self.eggMovementTimer invalidate];
    
    // Hides all components of the game.
    self.FistAttack.hidden = true;
    self.HealthBar.hidden = true;
    self.Score.hidden = true;
    self.Healthlabel.hidden = true;
    self.BorgBunnySprite.hidden = true;
    self.RoadmanShaq.hidden = true;
    self.AttackbuttonX.hidden = true;
    self.egg1.hidden = true;
    self.egg2.hidden = true;
    self.egg3.hidden = true;
    self.egg4.hidden = true;
    self.gameover.hidden = false;
    self.endgameQuit.hidden = false;
    self.endgameScore.hidden = false;
    self.endgameReplay.hidden = false;
    self.congratsName.hidden = false;
    
    // Displays the final score in the final view.
    self.endgameScore.text = [NSString stringWithFormat:@"Your Score = %d", score];
    self.currentScore = score;
    // Congratulates the user and displays his name which is set in settings
    self.congratsName.text = [NSString stringWithFormat:@"Congratulations %@", self.currentName];
    [MenuMusic stop];
    // Waits for a second before the game will initilise replay
    
    //[self performSelector:@selector(ReplayGame) withObject:nil afterDelay:1];
}

#pragma mark Replay Game Code

-(void)ReplayGame {
    // Restarts the game code
    
    // Displays the elements needed for the game when we press start. In turn the menu will be hidden.
    
    self.FistAttack.hidden = true;
    self.HealthBar.hidden = false;
    self.Score.hidden = false;
    self.Healthlabel.hidden = false;
    self.BorgBunnySprite.hidden = false;
    self.RoadmanShaq.hidden = false;
    self.AttackbuttonX.hidden = false;
    self.egg1.hidden = false;
    self.egg2.hidden = false;
    self.egg3.hidden = false;
    self.egg4.hidden = false;
    self.gameover.hidden = true;
    self.endgameQuit.hidden = true;
    self.endgameScore.hidden = true;
    self.endgameReplay.hidden = true;
    // Set the original value for score/health and using a string to display this.
    score = 0;
    
    self.Score.text = [NSString stringWithFormat:@"Score:   %d", score];
    self.HealthBar.progress = 1;
    
    // Setting the original positions for the sprites for when the game will load.
    
    self.RoadmanShaq.center = CGPointMake(50, 350);
    self.BorgBunnySprite.center = CGPointMake(785, 350);
    self.FistAttack.center = CGPointMake(self.RoadmanShaq.center.x, self.RoadmanShaq.center.y);
    self.Fireball.center = CGPointMake(self.BorgBunnySprite.center.x, self.BorgBunnySprite.center.y);
    self.egg1.center = CGPointMake(200, -20);
    self.egg2.center = CGPointMake(300, -20);
    self.egg3.center = CGPointMake(400, -20);
    self.egg4.center = CGPointMake(500, -20);
    
    [self bunnyPosition];
    
    self.eggMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(eggMovement) userInfo:nil repeats:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"passBackToMenu"]){
        MenuViewController *Controller = (MenuViewController *)segue.destinationViewController;
        Controller.userName2= self.currentName;
        NSLog(@"Name state in game = %@",self.currentName);
        NSLog(@"Name sent to menu = %@",Controller.userName);
        Controller.userScore = self.currentScore;
        NSLog(@"User score in game = %ld",self.currentScore);
        NSLog(@"User score sent to menu = %ld",Controller.userScore);
    }
    
    if ([segue.identifier isEqualToString:@"viewHighScore"]){
        SettingsViewController *Controller = (SettingsViewController *)segue.destinationViewController;
        Controller.compareScoreName= self.currentName;
        NSLog(@"Name state in game = %@",self.currentName);
        NSLog(@"Name sent to settings = %@",Controller.compareScoreName);
        Controller.compareScore = self.currentScore;
        NSLog(@"User score in game = %ld",self.currentScore);
        NSLog(@"User score sent to settings = %ld",Controller.compareScore);
    }
}

@end


/* References

 Background Image
 https://www.shutterstock.com/image-vector/high-quality-horizontal-seamless-background-landscape-555408847?src=aRWJoC8zBWet2x-B58pOkQ-1-19
 
 Background 
 https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b0e53331516629.565449774c2d4.png
 
 Fist Attack Pickture
https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5zAPPNnj_LlVi2YeVQOetsMrCmputmhjAu3z6cY8IxCZkb6EKJw
 
 Fireball Picture
 https://www.giantbomb.com/fireball/3055-120/
 
 
 Evil Bunny
 https://img00.deviantart.net/4733/i/2012/141/d/5/cyborg_bunny_by_crowsrock-d50l4tg.png
 
 VS image
 https://pre00.deviantart.net/e95c/th/pre/f/2017/183/7/f/yu_gi_oh__vrains__vs_screen__by_yugiohdragon999-dbet005.png
 
 Res/Blue colour background
 http://www.wallpapersxl.com/wallpaper/1920x1200/baground-wall-paper-hd-color-2066432.html?from=wallp
 
 Settings Background
 https://openclipart.org/image/2400px/svg_to_png/271573/ColourfulBackgroundColour2.png
 
 Instructions stage
 https://www.artstation.com/artwork/0knXw
 
 Font - Sixty
 https://www.dafont.com/change_display.php?author=592&page=1&fpp_old=20&ref=%2Fttf.d592&dsort=pop&fpp_default=20&text=Score%3A+++++74.+++++Health%3A+++++100&fpp=20&psize=m&sort=pop
 
 Font - Lead Coat
 https://www.dafont.com/lead-coat.font?text=Score%3A+++++74.+++++Health%3A+++++100
 
 Font - Sewer Sys
 https://www.dafont.com/sewer-sys.font?text=Score%3A+++++74.+++++Health%3A+++++100
 
 Font - Fast 99
 https://www.dafont.com/fast-99.font?text=Score%3A+++++74.+++++Health%3A+++++100
 
 Font - Asman
 https://www.dafont.com/asman.font?text=Score%3A+++++74.+++++Health%3A+++++100
 
 Reference for using sounds
 https://codewithchris.com/avaudioplayer-tutorial/
 
 Reference for highscore table 
 http://forum.cocos2d-objc.org/t/cocos2d-highscore-table/10527
 
 Reference for touch control
 https://stackoverflow.com/questions/26478879/how-to-create-a-d-pad-with-buttons-in-single-view-application-on-xcode
 
 Reference for Free Background Music
 https://www.melodyloops.com/music/free/
 
 Negative Random Generator
 https://stackoverflow.com/questions/27066668/arc4random-positive-negative-numbers
 
 Reference for touch control
 https://www.youtube.com/watch?v=F40uTsVd3lo
 
 
 
 
*/
