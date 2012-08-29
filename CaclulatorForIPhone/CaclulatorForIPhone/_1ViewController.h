//
//  _1ViewController.h
//  CaclulatorForIPhone
//
//  Created by Admin on 26.08.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Calculator.h"
int k =17;
@interface _1ViewController : UIViewController{
    NSMutableString *result;
    Calculator *myCalc;
//    char operation;
//    BOOL errorOccured;
//    BOOL clearCalcDisplay;
    IBOutlet UILabel *calcDisplay;
//    BOOL operationJustPerformed;
    }
-(IBAction) ButtonDigitClicked:(id)sender;
-(IBAction) ButtonDotClicked:(id)sender;
-(IBAction) ButtonOperationClicked:(id)sender;
-(IBAction) ButtonEqualClicked:(id)sender;
-(IBAction) ButtonCLRClicked:(id)sender;

@end
