//
//  TestViewController.m
//  Bill Calculator
//
//  Created by Stephen Sowole on 09/11/2013.
//  Copyright (c) 2013 Stephen Sowole. All rights reserved.
//

#import "TestViewController.h"
#define kOFFSET_FOR_KEYBOARD 130.0

NSString *prevEl = @"previousElectricity";
NSString *prevGa = @"previousGas";
NSString *currEl = @"currentElectricity";
NSString *currGa = @"currentGas";
BOOL predictedMoney = false;
double total;

@implementation TestViewController

@synthesize money;
@synthesize previousElectricity;
@synthesize previousGas;
@synthesize currentElectricity;
@synthesize currentGas;

- (void) viewDidLoad {
    settings = [NSUserDefaults standardUserDefaults];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self alignItems];
    
    if (![settings integerForKey:@"firstRun"]) {
        
        NSString *previous;
        
        previous = @"35";
        [settings setObject:previous forKey:prevGa];
        
        previous = @"83084";
        [settings setObject:previous forKey:prevEl];
        
        [settings setInteger:1 forKey:@"firstRun"];
    }
    
    previousGas.text = [settings objectForKey:prevGa];
    previousElectricity.text = [settings objectForKey:prevEl];
    currentGas.text = [settings objectForKey:currGa];
    currentElectricity.text = [settings objectForKey:currEl];
    
    [self calculate];
    
}

- (void) alignItems {
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
    BOOL isAtLeast7 = [version floatValue] >= 7.0;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        if (isAtLeast7) {
            
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                
                billLabel.center = CGPointMake(160, 56);
                prevGasLabel.center = CGPointMake(160, 120);
                previousGas.center = CGPointMake(160, 149);
                prevElecLabel.center = CGPointMake(160, 182);
                previousElectricity.center = CGPointMake(160, 211);
                money.center = CGPointMake(160, 268);
                currGasLabel.center = CGPointMake(160, 320);
                currentGas.center = CGPointMake(160, 348);
                currElecLabel.center = CGPointMake(160, 382);
                currentElectricity.center = CGPointMake(160, 412);
                calculateButton.center = CGPointMake(160, 502);
                
            } else {
                
                billLabel.center = CGPointMake(160, 46);
                prevGasLabel.center = CGPointMake(160, 90);
                previousGas.center = CGPointMake(160, 118);
                prevElecLabel.center = CGPointMake(160, 152);
                previousElectricity.center = CGPointMake(160, 180);
                money.center = CGPointMake(160, 230);
                currGasLabel.center = CGPointMake(160, 270);
                currentGas.center = CGPointMake(160,299);
                currElecLabel.center = CGPointMake(160, 332);
                currentElectricity.center = CGPointMake(160, 361);
                calculateButton.center = CGPointMake(160, 427);
                
            }
            
            
        } else {
            
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                
                billLabel.center = CGPointMake(160, 48);
                prevGasLabel.center = CGPointMake(160, 112);
                previousGas.center = CGPointMake(160, 141);
                prevElecLabel.center = CGPointMake(160, 174);
                previousElectricity.center = CGPointMake(160, 203);
                money.center = CGPointMake(160, 260);
                currGasLabel.center = CGPointMake(160, 312);
                currentGas.center = CGPointMake(160,340);
                currElecLabel.center = CGPointMake(160, 374);
                currentElectricity.center = CGPointMake(160, 402);
                calculateButton.center = CGPointMake(160, 492);
                
            } else {
                
                billLabel.center = CGPointMake(160, 34);
                prevGasLabel.center = CGPointMake(160, 76);
                previousGas.center = CGPointMake(160, 105);
                prevElecLabel.center = CGPointMake(160, 138);
                previousElectricity.center = CGPointMake(160, 167);
                money.center = CGPointMake(160, 215);
                currGasLabel.center = CGPointMake(160, 252);
                currentGas.center = CGPointMake(160, 281);
                currElecLabel.center = CGPointMake(160, 314);
                currentElectricity.center = CGPointMake(160, 343);
                calculateButton.center = CGPointMake(160, 409);
                
            }
        }
    }
}

- (void) predictMonthTotal {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = rng.length;
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    
    total = total / [[dateFormat stringFromDate:today] integerValue];
    
    total = total * numberOfDaysInMonth;
    
    NSString* cost = [NSString stringWithFormat:@"Predicted Cost: £%.2f", total];
    
    [money setFont:[UIFont systemFontOfSize:25]];
    
    money.text = cost;
    
}

- (void) calculate {
    
    double currGas = [currentGas.text doubleValue];
    double currElec = [currentElectricity.text doubleValue];
    double prevGas = [previousGas.text doubleValue];
    double prevElec = [previousElectricity.text doubleValue];
    
    double gasPrice = (currGas - prevGas);
    double electricityPrice = (currElec - prevElec);
    double standingCharge;
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    
    standingCharge = ([[dateFormat stringFromDate:today] doubleValue] - 1) * (26.09 * 2/100);
    gasPrice = gasPrice * 1.02264 * 39.32 * 4.128 / 360.0;
    electricityPrice = electricityPrice * 12.85 / 100.0;
    
    total = (gasPrice + standingCharge + electricityPrice) * 1.0185;
    
    if ((gasPrice == 0 && electricityPrice == 0) || (currGas == 0 && currElec == 0)) {
        total = 0;
    }
    
    NSString* cost = [NSString stringWithFormat:@"£%.2f", total];
    
    [money setFont:[UIFont systemFontOfSize:33]];
    
    money.text = cost;
    
}

- (void) saveSettings {
    
    [settings setObject:previousGas.text forKey:prevGa];
    [settings setObject:previousElectricity.text forKey:prevEl];
    [settings setObject:currentGas.text forKey:currGa];
    [settings setObject:currentElectricity.text forKey:currEl];
    [settings synchronize];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (CGRectContainsPoint([self.money frame], [touch locationInView:self.view])) {
        
        if (predictedMoney == false) {
            
            [self predictMonthTotal];
            
            predictedMoney = true;
            
            
        } else {
            
            [self calculate];
            
            predictedMoney = false;
            
        }
        
        
    }
    
}

- (IBAction) clickCalculate:(id)sender {
    
    [self calculate];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void) setViewMovedUp:(BOOL)movedUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void) keyboardWillShow {
    
    [self saveSettings];
    
    if (currentGas.isEditing || currentElectricity.isEditing) {
        
        // Animate the current view out of the way
        if (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
        
    }
    
}

- (void) keyboardWillHide {
    
    [self saveSettings];
    
    if (previousGas.isEditing == false && previousElectricity.isEditing == false) {
        
        if (self.view.frame.origin.y > 0)
        {
            [self setViewMovedUp:YES];
        }
        else if (self.view.frame.origin.y < 0)
        {
            [self setViewMovedUp:NO];
        }
    }
}

@end
