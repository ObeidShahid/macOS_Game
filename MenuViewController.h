//
//  MenuViewController.h
//  TheAdventuresOfBob
//
//  Created by Obeid Shahid [ll15os] on 29/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (strong, nonatomic) NSString *musicStatetoPass;
@property (strong, nonatomic) NSString *placeholderSwitchState;
@property (weak, nonatomic) IBOutlet UILabel *SwitchStateLabel;

@property NSInteger userScore;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userName2;


- (IBAction)StartGamePressed:(UIButton *)sender;
- (IBAction)InstructionsPrssed:(UIButton *)sender;
- (IBAction)SettingsPressed:(UIButton *)sender;

@end
