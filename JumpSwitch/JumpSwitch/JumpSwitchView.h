//
//  JumpSwitchView.h
//  JumpSwitch
//
//  Created by Ricky on 16/1/16.
//  Copyright © 2016年 Ricky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, STATE){
    ON,
    OFF,
};

@interface JumpSwitchView : UIView

@property (nonatomic, assign)STATE state;
@property (nonatomic, strong)UIImage *onImage;
@property (nonatomic, strong)UIImage *offImage;

- (void)startAnimate;

@end
