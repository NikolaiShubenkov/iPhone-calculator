//
//  NSString+Synbols.m
//  CaclulatorForIPhone
//
//  Created by Admin on 27.08.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import "NSString+Symbols.h"

@implementation NSString (Symbols)
-(BOOL) containSymbols: (NSString*) st{
    if([self rangeOfString: st].length >0 )
        return YES;
    else return NO;
}

-(NSString*) StringWithowtZeroesInFloatNumberAtAppendix{//return sring withowt additional 0 at the end
if([ self containSymbols: @"."]){
    int indexOfFirstAdditionalZero = [self length]-1;
    for (int i = indexOfFirstAdditionalZero - 1; i > 0; i--){
        if ( [self characterAtIndex: i] == '0' || [self characterAtIndex:i] == 'l')
            indexOfFirstAdditionalZero = i;
        else break;
    }
    //unichar a = '.';
    if( ([self characterAtIndex: indexOfFirstAdditionalZero - 1]  ) == '.')
        indexOfFirstAdditionalZero --;
    return [self substringToIndex: indexOfFirstAdditionalZero];
    }
NSString *p = [NSString stringWithFormat:@"%@",self];
return p;
}

       
@end
