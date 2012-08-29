//
//  Calculator.m
//  Glava4_Calculator
//
//  Created by Lion User on 11/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator
@synthesize accumulator, memory;


-(Calculator*) initWithAccumulator: (double) a AndMemory: (double) m{
    self = [super init];
    accumulator = a;
    memory = m;    
    return self;
}

-(Calculator*) init{
    return [self initWithAccumulator: 0 AndMemory: 0];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"Accumulator = %f\t memory = %f",accumulator,memory];
}

-(void) clear{
        accumulator = memory = 0;
}

@end

@implementation Calculator (MathOps)


-(double) add:(double) value{
    accumulator += value;
    return accumulator;
}

-(double) substract:(double) value{
    accumulator-=value;
    return accumulator;
}

-(double) multyply:(double) value{
    accumulator*=value;
    return accumulator;
}
-(double) divide:(double) value{
if(value == 0){
    @throw (@"Deviding by Zero");
    return -1;}
accumulator/=value;
return accumulator;
}
-(double) changeSign{
    accumulator*=-1;
    return accumulator;
    
}
-(double) reciprocal{
if(accumulator == 0){
    @throw (@"Dividing by Zero error");
return -1;
}
    accumulator=1/accumulator;
    return accumulator;
}
-(double) xSquared{
    accumulator*=accumulator;
    return accumulator;
}

-(double) pow: (double) a{
    
    accumulator = pow(accumulator,a);
    return accumulator;
}

-(double) sqrt{
    if(accumulator < 0){
        @throw (@"Sqrt from value below zero!");
        return -1;
    }
    accumulator = sqrt(accumulator);
    return accumulator;
}
@end//MathOps


@implementation Calculator(MemoryOps)

-(double) memoryClear{
    memory = 0;
    return accumulator;
}//Clear memory

-(double) memoryStore{
    memory = accumulator;
    return accumulator;
}//Store from accumulator to memory

-(double) memoryRecall{
    accumulator = memory;
    return accumulator;
}//Read from memory to accumulator


-(double) memoryAdd{
    memory +=accumulator;
    return accumulator;
}//memory = memory + accumulator

-(double) memorySubstract//memoru-= accumulator;
{
    memory -=accumulator;
    return accumulator;    
}
@end//MemoryOps
