//
//  NSDictionary+DS.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/5/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary(DS) 

-(NSString*) stringWithPath:(NSString*)path defaultValue:(NSString*)def;
-(int) intWithPath:(NSString*)path defaultValue:(int)def;
-(NSDate*) dateWithPath:(NSString*)path defaultValue:(NSDate*)def;
-(NSNumber*) intNumberWithPath:(NSString*)path defaultValue:(NSNumber*)def;
-(NSNumber*) doubleNumberWithPath:(NSString*)path defaultValue:(NSNumber*)def;


@end
