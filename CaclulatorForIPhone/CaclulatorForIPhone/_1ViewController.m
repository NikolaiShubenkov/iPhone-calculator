

//
//  _1ViewController.m
//  CaclulatorForIPhone
//
//  Created by Admin on 26.08.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#define _OP_CHANGE_SIGN     1
#define _OP_RECIPROCAL      2
#define _OP_SQUARED         3
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
#define _MAXIMUM_DIGITS_IN_DISPLAY      15
#import "_1ViewController.h"
#import "NSString+Symbols.h"


@interface _1ViewController ()

@end

static BOOL calcErrorOccured = NO;
static char lastOperation = 0;
static BOOL operationJustPerformed = NO;
static BOOL reset = YES;
static BOOL clearCalcDisplay = NO;
static double buffer;


@implementation _1ViewController


-(void) dealloc{
    [myCalc release];
    [result release];
    [calcDisplay release];
    [super dealloc];
}//dealloc

- (void)viewDidLoad
{
    [super viewDidLoad];
    myCalc = [[Calculator alloc]
              initWithAccumulator:0
              AndMemory:0];
    result = [[NSMutableString alloc]
              initWithCapacity:(14)];
    lastOperation = 0;
    clearCalcDisplay = NO;
    buffer = 0;
}//viewDidLoad

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
         [result setString: @""];
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
     else if([[calcDisplay text] length] < _MAXIMUM_DIGITS_IN_DISPLAY) {
         //clear extra 0
         if( [result  compare:@"0"] == NSOrderedSame)
             [result setString:@""];
         [result appendFormat:@"%i", [sender tag]];
         calcDisplay.text = result;
         operationJustPerformed = NO;
         }
 }//if error
}


-(IBAction) ButtonDotClicked:(id)sender{
 if(calcErrorOccured == NO){
    if(reset == YES || clearCalcDisplay == YES){
        reset = NO;
        clearCalcDisplay = NO;
        [result setString:@"0."];
        calcDisplay.text = result;
        operationJustPerformed = NO;
    }
    else if( [[calcDisplay text] containSymbols:@"."] == NO &&              // if there is no .
            [[calcDisplay text] length]  < _MAXIMUM_DIGITS_IN_DISPLAY  ) {  // and not too much digits
        if([[calcDisplay text] length] == 0)
            [result setString:@"0."];
        else [result appendFormat:@"."];
        calcDisplay.text = result;
        operationJustPerformed = NO;
    }
  }//if error
}// '.' clicked

                
-(IBAction) ButtonCLRClicked:(id)sender{
    [result setString:@"0"];
    calcDisplay.text = result;
    [myCalc clear];
    calcErrorOccured= NO;
    operationJustPerformed = NO;
    clearCalcDisplay = NO;
    reset = YES;
    buffer = 0;
    lastOperation = 0;
}//CLR clicked

-(IBAction) ButtonOperationWithTwoOperandsClicked:(id)sender{
    operationJustPerformed = NO;
    if(reset == YES){//if it just the beginning of calculations
        if( [sender tag] == _OP_SUBB ){
            [result setString:@"-"];
            reset = NO;
        }//if _OPP_SUBB
    }//if begiging of calculation
    else{
        lastOperation = [sender tag];
        myCalc.accumulator = [result doubleValue];
        clearCalcDisplay = YES;
    }//else

 }//Op with 2 operands clicked

-(void) displayResultWithPossibleErrorCode:(NSMutableString*) erCode{
    [result setString:[NSString stringWithFormat:@"%.*f",(_MAXIMUM_DIGITS_IN_DISPLAY-1), myCalc.accumulator]];
    if([result length] > _MAXIMUM_DIGITS_IN_DISPLAY && calcErrorOccured == NO){//if it is too much digits in result try to delete additional digits after '.'
        // add new String with length of location of first .
        int locationOfDot = [result rangeOfString:@"."].location;
        if(locationOfDot != NSNotFound &&               //  if result has dot
           locationOfDot < _MAXIMUM_DIGITS_IN_DISPLAY){ //  and it is located not much long from the begining
            [result setString:[result substringToIndex:_MAXIMUM_DIGITS_IN_DISPLAY+1]];
        }//if
        else{
            [erCode setString:@"Error. Too large result"];
            calcErrorOccured = YES;
        }//else
    }//if too much digits
    if(calcErrorOccured == YES){
        calcDisplay.text  = [NSString stringWithFormat:@"%@", erCode];
        reset = YES;
        [result setString:@"0"];
    }//if
    else{
        calcDisplay.text = [result StringWithowtZeroesInFloatNumberAtAppendix];
        clearCalcDisplay = YES;
        operationJustPerformed = YES;
    }//else
}//displayResultWithPossibleErrorCode

-(IBAction) ButtonEqualClicked:(id)sender{
 if(calcErrorOccured == NO && reset == NO){
    NSMutableString *errorCode = [[NSMutableString alloc] initWithCapacity:15];//for showing on display
    clearCalcDisplay = YES;
    if(operationJustPerformed == NO)//read displayValue to buffer if it was new operation
        buffer = [result doubleValue];
    switch (lastOperation) {
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
                [errorCode setString:@"Division by zero error!"];
                 break;
            }
            else {
                [myCalc divide:buffer];
                break;
            }
        case _OP_POW:
            [myCalc pow: buffer];
            break;            
        case _OP_RECIPROCAL:
            if(myCalc.accumulator != 0)
                buffer = [myCalc reciprocal];
            else {//error
                calcErrorOccured = YES;
                [errorCode setString:@"Division by zero Error"];
            }//else error
            break;
        case _OP_SQRT:
            if(buffer > 0)
                buffer = [myCalc sqrt];
            else{
                calcErrorOccured = YES;
                [errorCode setString:@"Squre from the below zero value error"];
            }
            break;
    }//switch
     [self displayResultWithPossibleErrorCode:errorCode];
     [errorCode release];
 }//if no error
}//button error clicked

-(IBAction)ButtonOperationWithMemoryClicked:(id)sender{
    if(calcErrorOccured == NO && reset == NO){
        lastOperation = [sender tag];
        if(operationJustPerformed == NO)
            myCalc.accumulator = [result doubleValue];
        switch (lastOperation) {
            case _OP_MEMORY_ADD:
                [myCalc memoryAdd];
                break;
            case _OP_MEMORY_SUBSTRACT:
                [myCalc memorySubstract];
                break;
            case _OP_MEMORY_STORE:
                [myCalc memoryStore];
                break;
            case _OP_MEMORY_CLEAR:
                [myCalc memoryClear];
                break;
            case _OP_MEMORY_RECALL:
                [myCalc memoryRecall];
                break;
        }//switch
        [result setString: [NSString stringWithFormat:@"%.*f",(_MAXIMUM_DIGITS_IN_DISPLAY-1),myCalc.accumulator]];
        calcDisplay.text = [result StringWithowtZeroesInFloatNumberAtAppendix];
        clearCalcDisplay  = YES;
    }
    
}//button memory operation clicked

-(IBAction) ButtonOperationWithResultClicked:(id)sender{
    if(calcErrorOccured == NO && reset == NO){
        NSMutableString *errorCode = [[NSMutableString alloc] initWithCapacity:15];
        lastOperation = [sender tag];
        if(operationJustPerformed == NO)
            myCalc.accumulator = [[calcDisplay text]doubleValue];
        switch (lastOperation) {
            case _OP_RECIPROCAL:
                if(myCalc.accumulator != 0)
                    buffer = [myCalc reciprocal];
                else {//error
                    calcErrorOccured = YES;
                    [errorCode setString:@"Division by zero Error"];
                }//else error
                break;
            case _OP_SQRT:
                if(myCalc.accumulator >= 0)
                    [myCalc sqrt];
                else{
                    calcErrorOccured = YES;
                    [errorCode setString:@"Squre from the below zero value error"];
                }
                break;
        }//switch
       [self displayResultWithPossibleErrorCode:errorCode];
        [errorCode release];
    }//if
}//button operation with result clicked

@end




