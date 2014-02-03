//
//  TestViewController.h
//  Bill Calculator
//
//  Created by Stephen Sowole on 09/11/2013.
//  Copyright (c) 2013 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController {

    IBOutlet UITextField *previousGas;
    
    IBOutlet UITextField *previousElectricity;

    IBOutlet UITextField *currentElectricity;

    IBOutlet UITextField *currentGas;
    
    IBOutlet UILabel *money;
    
    IBOutlet UIButton *calculateButton;
    
    IBOutlet UILabel *currElecLabel;
    
    IBOutlet UILabel *currGasLabel;
    
    IBOutlet UILabel *prevElecLabel;
    
    IBOutlet UILabel *prevGasLabel;
    
    IBOutlet UILabel *billLabel;
    
    NSUserDefaults *settings;
}

- (IBAction)clickCalculate:(id)sender;

@property(strong, nonatomic) UITextField *previousGas;
@property(strong, nonatomic) UITextField *previousElectricity;
@property(strong, nonatomic) UITextField *currentGas;
@property(strong, nonatomic) UITextField *currentElectricity;
@property(strong, nonatomic) UILabel *money;

@end
