//
//  JumpSwitchView.m
//  JumpSwitch
//
//  Created by Ricky on 16/1/16.
//  Copyright © 2016年 Ricky Lee. All rights reserved.
//

#import "JumpSwitchView.h"

#define jumpDuration 0.125
#define downDuration 0.215

static NSString* const JUMPUPANIMATION = @"jumpup";
static NSString* const DOWNANIMATION = @"down";

@interface JumpSwitchView()

@property(nonatomic,strong)UIImageView *mainView;
@property(nonatomic,strong)UIImageView *shadowView;

@end

@implementation JumpSwitchView{
    BOOL isAnimating;
}
#pragma mark -
#pragma mark - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    if (self.mainView == nil) {
        self.mainView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - (self.bounds.size.width-6)/2, 0, self.bounds.size.width-6, self.bounds.size.height - 6)];
        self.mainView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.mainView];
    }
    if (self.shadowView == nil) {
        self.shadowView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2 - 10/2, self.bounds.size.height - 3, 10, 3)];
        self.shadowView.alpha = 0.4;
        self.shadowView.image = [UIImage imageNamed:@"shadow_new"];
        [self addSubview:self.shadowView];

    }
}
#pragma mark -
#pragma mark - setter
- (void)setState:(STATE)state{
    _state = state;
    self.mainView.image = state == ON ? self.onImage : self.offImage;
}

#pragma mark -
#pragma mark - animation

//上升动画
- (void)startAnimate{
    if (isAnimating) {
        return;
    }
    
    isAnimating = YES;
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.fromValue = @(self.mainView.center.y);
    positionAnimation.toValue = @(self.mainView.center.y - 14);
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    transformAnimation.fromValue = @(0);
    transformAnimation.toValue = @(M_PI_2);
    transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, transformAnimation];
    animationGroup.duration = jumpDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    
    [self.mainView.layer addAnimation:animationGroup forKey:JUMPUPANIMATION];
}

//下降动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isEqual:[self.mainView.layer animationForKey:JUMPUPANIMATION]]) {
        
        self.state = self.state == ON ? OFF : ON;
                
        CABasicAnimation *transformAnima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        transformAnima.fromValue = @(M_PI_2);
        transformAnima.toValue = @(M_PI);
        transformAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAnima.fromValue = @(self.mainView.center.y - 14);
        positionAnima.toValue = @(self.mainView.center.y);
        positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.duration = downDuration;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.removedOnCompletion = NO;
        animGroup.delegate = self;
        animGroup.animations = @[transformAnima,positionAnima];
        
        [self.mainView.layer addAnimation:animGroup forKey:DOWNANIMATION];
        
    }else if([anim isEqual:[self.mainView.layer animationForKey:DOWNANIMATION]]){
        
        [self.mainView.layer removeAllAnimations];
        isAnimating = NO;
    }
}
//阴影动画
- (void)animationDidStart:(CAAnimation *)anim{
    if ([anim isEqual:[self.mainView.layer animationForKey:JUMPUPANIMATION]]) {
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            _shadowView.alpha = 0.2;
            _shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width*1.6, _shadowView.bounds.size.height);
        } completion:NULL];
        
    }else if ([anim isEqual:[self.mainView.layer animationForKey:DOWNANIMATION]]){
        
        [UIView animateWithDuration:jumpDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            _shadowView.alpha = 0.4;
            _shadowView.bounds = CGRectMake(0, 0, _shadowView.bounds.size.width/1.6, _shadowView.bounds.size.height);
            
        } completion:NULL];
        
    }
}
@end
