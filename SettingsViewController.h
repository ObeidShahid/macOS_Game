//
//  SettingsViewController.h
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 30/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *enterName;
@property (weak, nonatomic) IBOutlet UILabel *musicState;
@property (weak, nonatomic) NSString *highscoreSetbyValueX;
@property (weak, nonatomic) IBOutlet UILabel *highScoreSetbyValue;

@property (strong, nonatomic) NSString *musicStatetoPass;
@property (strong, nonatomic) NSString *placeholderSwitchState2;
@property (strong, nonatomic) NSString *setName;
@property (strong, nonatomic) NSString *emptyName;
@property (strong, nonatomic) NSString *recentGamePlayerName;
@property NSInteger recentGamePlayerScore;
@property (strong, nonatomic) NSString *highscoreGamePlayerName;
@property NSInteger highsoreGamePlayerScore;

@property (strong, nonatomic) NSString *highScoreName;
@property (strong, nonatomic) NSString *compareScoreName;
@property NSInteger highScore;
@property NSInteger compareScore;

- (IBAction)musicState:(UISwitch *)sender;
- (IBAction)BackButtonPressed:(UIButton *)sender;
- (IBAction)RemoveKeyboard:(UIControl *)sender;
- (IBAction)saveName:(UIButton *)sender;

@end
