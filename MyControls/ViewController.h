//
//  ViewController.h
//  MyControls
//
//  Created by Eduard Galchenko on 1/8/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *speedAnimationSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *picturesSegmentedControl;
@property (weak, nonatomic) IBOutlet UIView *screenView;
@property (weak, nonatomic) IBOutlet UISwitch *valueRotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *valueScaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *valueTranslationSwitch;



- (IBAction)rotationSwitch:(UISwitch *)sender;
- (IBAction)scaleSwitch:(UISwitch *)sender;
- (IBAction)translationSwitch:(UISwitch *)sender;
- (IBAction)actionSlider:(UISlider *)sender;
- (IBAction)pictureChooserSegmented:(UISegmentedControl *)sender;




@end


