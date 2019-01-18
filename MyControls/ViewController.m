//
//  ViewController.m
//  MyControls
//
//  Created by Eduard Galchenko on 1/8/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView* imageView;

@end

typedef enum {
    
    EGBLogoTypeApple,
    EGBLogoTypeRockStar,
    EGBLogoTypeBmw
    
} EGBLogoType;

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(300, 300, 300, 300)];
    
    self.picturesSegmentedControl.selectedSegmentIndex = EGBLogoTypeApple;
    
    self.imageView.image = [UIImage imageNamed:@"apple_logo.png"];
    [self.screenView addSubview:self.imageView];
    
    [self moveView:self.imageView];
}

#pragma mark - Animation Methods

- (void) moveView:(UIView*) view {
    
    CGFloat x = arc4random() % (int)self.screenView.bounds.size.width;
    CGFloat y = arc4random() % (int)self.screenView.bounds.size.height;
    
    CGFloat s = (float)(arc4random() % 151) / 100.f + 0.5f;
    CGFloat r = (float)(arc4random() % (int)(M_PI * 2*10000)) / 10000 - M_PI;
    CGFloat d = (float)(arc4random() % 20001) / 100002;
    
    d = d / self.speedAnimationSlider.value * 7;
    
    CGPoint center = self.imageView.center;

    if (self.valueTranslationSwitch.isOn == YES) {

        center = CGPointMake(x, y);
    }

    CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
    CGAffineTransform rotation = CGAffineTransformMakeRotation(r);
    
    CGAffineTransform test = CGAffineTransformMakeRotation(0);
    CGAffineTransform transform = test;

    if (self.valueScaleSwitch.isOn == YES) {

        scale = CGAffineTransformMakeScale(s, s);
        transform = scale;
    }

    if (self.valueRotationSwitch.isOn == YES) {

        rotation = CGAffineTransformMakeRotation(r);
        transform = rotation;
    }
    
    if (self.valueRotationSwitch.isOn == YES && self.valueScaleSwitch.isOn == YES) {
        
        transform = CGAffineTransformConcat(scale, rotation);
    }
    
    [UIView animateWithDuration: d
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.imageView.center = center;

                         if (self.valueRotationSwitch.isOn == YES || self.valueScaleSwitch.isOn == YES) {

                             view.transform = transform;
                         }
                     }
     
                     completion:^(BOOL finished) {
                         NSLog(@"animation finished! %d", finished);
                         NSLog(@"\nview frame = %@\nview bounds = %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));

                         __weak UIView* v = view;
                         [self moveView:v];
                     }];
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)stopAnimation:(BOOL)withoutFinishing {
    
    [self.imageView.layer removeAllAnimations];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Controls

- (IBAction)rotationSwitch:(UISwitch *)sender {
    
    [self checkingSwitchersStates];
}

- (IBAction)scaleSwitch:(UISwitch *)sender {
    
    [self checkingSwitchersStates];
}

- (IBAction)translationSwitch:(UISwitch *)sender {
    
    [self checkingSwitchersStates];
}

- (IBAction)actionSlider:(UISlider *)sender {
    
    self.speedAnimationSlider.value = sender.value;
    
    NSLog(@"%f", self.speedAnimationSlider.value);
}

- (IBAction)pictureChooserSegmented:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case EGBLogoTypeApple:
            self.imageView.image = [UIImage imageNamed:@"apple_logo.png"];
            break;
            
            case EGBLogoTypeRockStar:
            self.imageView.image = [UIImage imageNamed:@"rockstar_logo.png"];
            break;
            
            case EGBLogoTypeBmw:
            self.imageView.image = [UIImage imageNamed:@"bmw_logo.png"];
            break;
            
        default:
            self.imageView.image = [UIImage imageNamed:@"apple_logo.png"];
            break;
    }
}

#pragma mark - Private Methods

- (void) checkingSwitchersStates {
    
    if (self.valueScaleSwitch.isOn == NO && self.valueRotationSwitch.isOn == NO
        && self.valueTranslationSwitch.isOn == NO) {
        
        [self.imageView.layer removeAllAnimations];
    }
}

@end
