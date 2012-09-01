//
//  _1ViewController.h
//  CaclulatorForIPhone
//
//  Created by Admin on 26.08.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Calculator.h"

@interface _1ViewController : UIViewController{
    NSMutableString *result;
    Calculator *myCalc;
    IBOutlet UILabel *calcDisplay;
    }
-(IBAction) ButtonDigitClicked:(id)sender;
-(IBAction) ButtonDotClicked:(id)sender;
-(IBAction) ButtonOperationWithTwoOperandsClicked:(id)sender;
-(IBAction) ButtonOperationWithResultClicked:(id)sender;
-(IBAction) ButtonOperationWithMemoryClicked:(id)sender;
-(IBAction) ButtonEqualClicked:(id)sender;
-(IBAction) ButtonCLRClicked:(id)sender;

@end
