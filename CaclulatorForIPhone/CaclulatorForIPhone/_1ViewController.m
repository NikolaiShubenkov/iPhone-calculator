

//
//  _1ViewController.m
//  CaclulatorForIPhone
//
//  Created by Admin on 26.08.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#define _OP_CHANGE_SIGN     1
#define _OP_RECIPROCAL      2
#define _OP_SQEARED         3
#define _OP_POW             4
#define _OP_SQRT            5
#define _OP_MEMORY_CLEAR    6
#define _OP_MEMORY_STORE    7
#define _OP_MEMORY_RECALL   8
#define _OP_MEMORY_ADD      9
#define _OP_MEMORY_SUBSTRACT 10
#define _CLR                11
#define _OP_ADD             12
#define _OP_SUBB            13
#define _OP_MULTIPLY        14
#define _OP_DEVIDE          15
#define _OP_CLR             16
#import "_1ViewController.h"
#import "NSString+Symbols.h"

static BOOL calcErrorOccured = NO;
static char operation = 0;
static BOOL operationJustPerformed = NO;
static BOOL reset = YES;
static BOOL clearCalcDisplay = NO;
static double buffer;

@interface _1ViewController ()

@end

@implementation _1ViewController


-(void) dealloc{
    [myCalc release];
    [result release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myCalc = [[Calculator alloc]
              initWithAccumulator:0
              AndMemory:0];
    result = [[NSMutableString alloc]
              initWithCapacity:(10)];
    operation = '0';
    clearCalcDisplay = NO;
    buffer = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)ButtonDigitClicked:(id)sender{//Every button's tag is equal to its Label
 if(calcErrorOccured== NO){
     if(reset == YES ){
         if(operation == _OP_SUBB)
             [result setString: @"-"];
         [result appendFormat:@"%i",[sender tag]];
         calcDisplay.text = result;
         reset = NO;
         clearCalcDisplay = NO;
          
     }
     else
     if(clearCalcDisplay == YES){
         [result setString:@""];
         [result appendFormat:@"%i",[sender tag]];
            calcDisplay.text = result;
            clearCalcDisplay = NO;
         operationJustPerformed = NO;
         
     }
     else if([[calcDisplay text] length] < 15) {
      /*   if( [result length] == 0 && reset == YES && operation == _OP_SUBB){
             [result setString: @"-"];
             reset = NO;
         }
         else */if( [result  compare:@"0"] == NSOrderedSame)
             [result setString:@""];
         [result appendFormat:@"%i", [sender tag]];
         calcDisplay.text = result;
         operationJustPerformed = NO;
         }
     }
}


-(IBAction)ButtonDotClicked:(id)sender{
if(calcErrorOccured == NO)
    if(reset == YES){
        [result setString:@"0."];
    }
    else if( [[calcDisplay text] length] < 15){
        if(operationJustPerformed == YES || clearCalcDisplay == YES){
            [result setString:@"0."];
            operationJustPerformed = NO;
            clearCalcDisplay = NO;
        }
        else if([[calcDisplay text] length] == 0)//if there is no coma
            [result setString:@"0."];
        //else if[result setstr
        else if( [[calcDisplay text] containSymbols:@"."] == NO)
                  calcDisplay.text = result;
//       myCalc.accumulator = [result doubleValue];
    }
}
                
-(IBAction)ButtonCLRClicked:(id)sender{
    [result setString:@"0"];
    calcDisplay.text = result;
    [myCalc clear];
    calcErrorOccured= NO;
    operationJustPerformed = NO;
    clearCalcDisplay = NO;
    reset = YES;
    buffer = 0;
    operation = 0;
}

-(IBAction)ButtonOperationClicked:(id)sender{
if(calcErrorOccured == NO){
    operationJustPerformed = NO;
    if(reset == YES){
        if( [sender tag] == _OP_SUBB)
            operation = _OP_SUBB;
    }
    else {
        operation = [sender tag];
        clearCalcDisplay = YES;
        myCalc.accumulator = [result doubleValue];
   }
}
}

-(IBAction)ButtonEqualClicked:(id)sender{
if(calcErrorOccured == 0 || !reset){
    clearCalcDisplay = YES;
    if(operationJustPerformed == NO)
        buffer = [result doubleValue];
    switch (operation) {
        case _OP_ADD:
            [myCalc add:buffer];
            break;
        case _OP_SUBB:
            [myCalc substract:buffer];
            break;
        case _OP_MULTIPLY:
            [myCalc multyply:buffer];
            break;
        case _OP_DEVIDE:
            if(buffer == 0){
                 calcErrorOccured = YES;
                 break;
            }
            else {
                [myCalc divide:buffer];
                break;
            }
        case _OP_CHANGE_SIGN:{
            [myCalc changeSign];
            break;
        case _OP_SQEARED:{
            if( myCalc.accumulator == 0){
                calcErrorOccured = YES;
                break;
            }
            else{if (operationJustPerformed == NO)
                    myCalc.accumulator = buffer;
                [myCalc sqrt];
            }
            break;
        }
        case _OP_POW:{
            [myCalc pow: buffer];
            break;
        }
        /*
#define _OP_CHANGE_SIGN     1
#define _OP_RECIPROCAL      2
#define _OP_SQEARED         3
#define _OP_POW             4
#define _OP_SQRT            5
#define _OP_MEMORY_CLEAR    6
#define _OP_MEMORY_STORE    7
#define _OP_MEMORY_RECALL   8
#define _OP_MEMORY_ADD      9
#define _OP_MEMORY_SUBSTRACT 10
#define _CLR                11
#define _OP_ADD             12
#define _OP_SUBB            13
#define _OP_MULTIPLY        14
#define _OP_DEVIDE          15
#define _OP_CLR             16
*/
        }
    }
        
    if(calcErrorOccured == YES){
        calcDisplay.text = [NSString stringWithFormat:@"Error"];
        [result setString:@"0"];
    }
    else{
        [result setString:[NSString stringWithFormat:@"%fl", myCalc.accumulator]];
         calcDisplay.text = [result StringWithowtZeroesInFloatNumberAtAppendix];
        clearCalcDisplay = YES;
        operationJustPerformed = YES;
    }
  }
}

@end
