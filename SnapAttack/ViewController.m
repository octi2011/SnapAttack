//
//  ViewController.m
//  SnapAttack
//
//  Created by Duminica Octavian on 24/03/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    timeInt = 20;
    scoreInt = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startGame:(id)sender {
    
    if (timeInt == 20) {
        gameInt = 1;
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        imageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(cardUpdate) userInfo:nil repeats:YES];
        
        self.startGameButton.enabled = NO;
        self.startGameButton.alpha = 0.5;
        
        [self.startGameButton setTitle:@"Snap" forState:UIControlStateNormal];
        
    }
 
    if (gameInt == 1) {
        if ([self.imageView1.image isEqual:self.imageView2.image]) {
            scoreInt += 1;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", scoreInt];
        } else {
            scoreInt -= 1;
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", scoreInt];
        }
    } else {
        timeInt = 20;
        scoreInt = 0;
        
        self.timeLabel.text = [NSString stringWithFormat:@"Time: %i", timeInt];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", scoreInt];
        
        self.imageView1.image = [UIImage imageNamed:@"blue_cover.png"];
        self.imageView2.image = [UIImage imageNamed:@"blue_cover.png"];
        
        [self.startGameButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
}

- (void)updateTimer {
    timeInt -= 1;
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %i", timeInt];
    
    gameInt = 1;
    
    self.startGameButton.enabled = YES;
    self.startGameButton.alpha = 1.0;
    
    if (timeInt == 0) {
        [timer invalidate];
        [imageTimer invalidate];
        
        gameInt = 0;
        
        [self.startGameButton setTitle:@"Restart" forState:UIControlStateNormal];
        
        self.startGameButton.enabled = NO;
        self.startGameButton.alpha = 0.5;
        
        [self performSelector:@selector(restartTrigger) withObject:nil afterDelay:4.0];
    }
}

- (void)restartTrigger {
    self.startGameButton.enabled = YES;
    self.startGameButton.alpha = 1.0;
    
    gameInt = 0;
}

- (void)cardUpdate {
    NSArray *cardList = @[@"ace_of_hearts.png",
                          @"2_of_hearts.png",
                          @"3_of_hearts.png",
                          @"4_of_hearts.png",
                          @"5_of_hearts.png",
                          @"6_of_hearts.png",
                          @"7_of_hearts.png",
                          @"8_of_hearts.png",
                          @"9_of_hearts.png",
                          @"10_of_hearts.png"];
    
    int randomCard1 = arc4random() % cardList.count;
    self.imageView1.image = [UIImage imageNamed:cardList[randomCard1]];
    
    int randomCard2 = arc4random() % cardList.count;
    self.imageView2.image = [UIImage imageNamed:cardList[randomCard2]];
}
@end
