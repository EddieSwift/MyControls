//
//  AXLViewController.m
//  Lesson-26
//
//  Created by Дмитрий Пономарев on 25.08.14.
//  Copyright (c) 2014 ArmyXomuiL. All rights reserved.
//

#import "AXLViewController.h"

typedef enum {
    
    firstSelectedImage,
    secondSelectedImage,
    thridSelectedImage
    
} SelectedImage;

@interface AXLViewController ()

@property (assign, nonatomic)CGPoint startPoint;
@property (assign, nonatomic)CGFloat startAngle;
@property (assign, nonatomic)CGFloat startScale;

@property (strong, nonatomic)CABasicAnimation* translationAnimation;
@property (strong, nonatomic)CABasicAnimation* scaleAnimation;
@property (strong, nonatomic)CABasicAnimation* rotationAnimation;

@end

@implementation AXLViewController

#pragma mark - Standart Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (IBAction)changeSliderValue:(UISlider *)sender {
    self.speedSlider.value = sender.value;
    
    [self changeRotationSwitch:nil];
    [self changeScaleSwitch:nil];
    [self changeTranslationSwitch:nil];
}

- (IBAction)changeImageView:(UISegmentedControl *)sender {
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Image - %ld.png", (long)sender.selectedSegmentIndex + 1]]; //Выбираем одну из трех Image
}

#pragma mark - Change Switches

- (IBAction)changeRotationSwitch:(UISwitch *)sender {
    if (!self.rotationSwitch.isOn) {
        self.startAngle = [self getCurrentRotationOfLayerInAnimation];
        [self.imageView.layer removeAnimationForKey:@"rotation"];
        self.imageView.transform = CGAffineTransformMakeRotation(self.startAngle);
        return;
    }
    
    [self setRotationAnimation];
     
    if (self.rotationSwitch.isOn) {
        [self.imageView.layer addAnimation:self.rotationAnimation forKey:@"rotation"];
    }
    
}

- (IBAction)changeScaleSwitch:(UISwitch *)sender {
    if (!self.scaleSwitch.isOn) {
        self.startScale = [self getCurrentScaleOfLayerInAnimation];
        [self.imageView.layer removeAnimationForKey:@"scale"];
        self.imageView.transform = CGAffineTransformMakeScale(self.startScale, self.startScale);
        return;
    }
    
    [self setScaleAnimation];
    
    if (self.scaleSwitch.isOn) {
        [self.imageView.layer addAnimation:self.scaleAnimation forKey:@"scale"];
    }
}

- (IBAction)changeTranslationSwitch:(UISwitch *)sender {
    if (!self.translationSwitch.isOn) {
        self.startPoint = [self getCurrentPositionOfLayerInAnimation];
        [self.imageView.layer removeAnimationForKey:@"translation"];
        self.imageView.center = self.startPoint;
        return;
    }
    
    [self setTranslationAnimation];
    
    if (self.translationSwitch.isOn) {
        [self.imageView.layer addAnimation:self.translationAnimation forKey:@"translation"];
    }
}

#pragma mark - Animations 

- (void)setRotationAnimation {
    self.startAngle = [self getCurrentRotationOfLayerInAnimation];
    
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation.fromValue = [NSNumber numberWithFloat:self.startAngle];
    self.rotationAnimation.toValue = [NSNumber numberWithFloat:self.startAngle + M_PI * 2];
    self.rotationAnimation.duration =  [self getAnimationTime];
    self.rotationAnimation.repeatCount = HUGE_VALF;
}

- (void)setScaleAnimation {
    self.startScale = [self getCurrentScaleOfLayerInAnimation];
    
    self.scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.scaleAnimation.fromValue = [NSNumber numberWithFloat:self.startScale];
    self.scaleAnimation.toValue = [NSNumber numberWithFloat:3];
    self.scaleAnimation.duration = [self getAnimationTime];
    self.scaleAnimation.repeatCount = HUGE_VALF;
    self.scaleAnimation.autoreverses = YES;
}

- (void)setTranslationAnimation {
    self.startPoint = [self getCurrentPositionOfLayerInAnimation];
    
    self.translationAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    self.translationAnimation.fromValue = [NSValue valueWithCGPoint:self.startPoint];
    self.translationAnimation.toValue = [NSValue valueWithCGPoint:[self getRandomPointInView]];
    self.translationAnimation.duration = [self getAnimationTime];
    self.translationAnimation.repeatCount = HUGE_VALF;
    self.translationAnimation.autoreverses = YES;
}

#pragma mark - Methods

- (CGPoint)getCurrentPositionOfLayerInAnimation {
    return [[[self.imageView.layer presentationLayer]valueForKeyPath:@"position"] CGPointValue];
}

- (CGFloat)getCurrentRotationOfLayerInAnimation {
    return [[[self.imageView.layer presentationLayer]valueForKeyPath:@"transform.rotation.z"] floatValue];
}

- (CGFloat)getCurrentScaleOfLayerInAnimation {
    return [[[self.imageView.layer presentationLayer]valueForKeyPath:@"transform.scale"] floatValue];
}

- (CGFloat)getAnimationTime {
    return 1 / self.speedSlider.value;
}

- (CGPoint)getRandomPointInView {
    return CGPointMake(arc4random() % (int)self.view.frame.size.width, arc4random() % (int)self.view.frame.size.height);
}

@end
