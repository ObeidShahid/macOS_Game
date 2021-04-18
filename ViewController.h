//
//  ViewController.h
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 13/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *RoadmanShaq;
@property (weak, nonatomic) IBOutlet UILabel *Score;
@property (weak, nonatomic) IBOutlet UIProgressView *HealthBar;
@property (weak, nonatomic) IBOutlet UIButton *AttackbuttonX;
@property (weak, nonatomic) IBOutlet UIButton *StartGameX;
@property (weak, nonatomic) IBOutlet UILabel *Healthlabel;
@property (weak, nonatomic) IBOutlet UIImageView *BorgBunnySprite;
@property (weak, nonatomic) IBOutlet UIImageView *Fireball;
@property (weak, nonatomic) IBOutlet UIImageView *FistAttack;
@property (weak, nonatomic) IBOutlet UIButton *Settingsbutton;
@property (weak, nonatomic) IBOutlet UIButton *instructionsbutton;
@property (weak, nonatomic) IBOutlet UIButton *startgamebutton;
@property (weak, nonatomic) IBOutlet UIImageView *egg1;
@property (weak, nonatomic) IBOutlet UIImageView *egg2;
@property (weak, nonatomic) IBOutlet UIImageView *egg3;
@property (weak, nonatomic) IBOutlet UIImageView *egg4;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBorder;
@property (weak, nonatomic) IBOutlet UIImageView *leftBorder;
@property (weak, nonatomic) IBOutlet UIImageView *rightBorder;
@property (weak, nonatomic) IBOutlet UILabel *endgameScore;
@property (weak, nonatomic) IBOutlet UIButton *endgameQuit;
@property (weak, nonatomic) IBOutlet UILabel *congratsName;

@property (strong ,nonatomic) UITouch *touch;
@property (strong, nonatomic) NSTimer *fireballMovementTimer;
@property (strong, nonatomic) NSTimer *fistattackMovementTimer;
@property (strong, nonatomic) NSTimer *bunnyMovementTimer;
@property (strong, nonatomic) NSTimer *eggMovementTimer;
@property (weak, nonatomic) IBOutlet UILabel *gameover;

- (IBAction)StartGame:(UIButton *)sender;
- (IBAction)AttackButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *endgameReplay;
- (IBAction)endgameReplayc:(UIButton *)sender;
- (IBAction)endgameQuit:(UIButton *)sender;

@property (strong, nonatomic) NSString *currentName;
@property NSInteger currentScore;

- (IBAction)userMoveLeft:(UIButton *)sender;
- (IBAction)userStopLeft:(UIButton *)sender;
- (IBAction)userMoveRight:(UIButton *)sender;
- (IBAction)userStopRight:(UIButton *)sender;
- (IBAction)userDragStopLeft:(UIButton *)sender;
- (IBAction)userDragStopRight:(UIButton *)sender;
@property (strong, nonatomic) NSTimer *leftTimer;
@property (strong, nonatomic) NSTimer *rightTimer;

@property (strong, nonatomic) NSString *placeholderSwitchState2;
@property (strong, nonatomic) NSString *playerName;

-(void)fistattackMovement;
-(void)bunnyPosition;
-(void)bunnyMovementTimerx;
-(void)bunnyMovement;
-(void)eggMovement;
-(void)GameOver;
-(void)userRight;
-(void)userLeft;
@end

