//
//  NSString+Synbols.h
//  CaclulatorForIPhone
//
//  Created by Admin on 27.08.12.
//  Copyright (c) 2012 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Symbols)
-(BOOL) containSymbols: (NSString*) st;//dlya provery soderchatsya li v stroke simvoly
-(NSString*) StringWithowtZeroesInFloatNumberAtAppendix;//ubiraet lishnie nuli v stroke/ predpolagaetsya, chto eto chislo

@end
