//
//  Calculator.h
//  Glava4_Calculator
//
//  Created by Lion User on 11/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>


@interface Calculator : NSObject{
    double accumulator; 
    double memory;
}
@property double accumulator, memory;
-(Calculator*) initWithAccumulator: (double) a AndMemory: (double) m;
-(void) clear;
@end


@interface Calculator (MathOps)
-(double) add:(double) value;
-(double) substract:(double) value;
-(double) multyply:(double) value;
-(double) divide:(double) value;
-(double) changeSign;
-(double) reciprocal;
-(double) xSquared;
-(double) pow: (double) a;
-(double) sqrt;
@end


@interface Calculator (MemoryOps)
-(double) memoryClear;//Clear memory
-(double) memoryStore;//Store from accumulator to memory
-(double) memoryRecall;//Read from memory to accumulator
-(double) memoryAdd;//memory = memory + accumulator
-(double) memorySubstract;//memoru-= accumulator;

@end
