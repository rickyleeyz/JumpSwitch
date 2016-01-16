//
//  ViewController.m
//  JumpSwitch
//
//  Created by Ricky on 16/1/16.
//  Copyright © 2016年 Ricky Lee. All rights reserved.
//

#import "ViewController.h"
#import "JumpSwitchView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet JumpSwitchView *jumpSwitchView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_jumpSwitchView layoutIfNeeded];
    _jumpSwitchView.onImage = [UIImage imageNamed:@"icon_star_incell"];
    _jumpSwitchView.offImage = [UIImage imageNamed:@"blue_dot"];
    _jumpSwitchView.state = ON;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClicked:(id)sender {
    [self.jumpSwitchView startAnimate];
}

@end
