//
//  NSDictionary+DS.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/5/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "NSDictionary+DS.h"


@implementation NSDictionary(DS) 

-(id) objectAtPath:(NSString*)path
{
	NSArray* comps = [path pathComponents];
	
	if (!comps || !comps.count) return nil;
	
	id tree = self;
	for (NSString* comp in comps)
	{
		// Ignore the possible beginning root path
		if ([comp isEqual:@"/"]) continue;

		if (![tree isKindOfClass:[NSDictionary class]]) 
		{
			// Allow array indexing by number
			if (![tree isKindOfClass:[NSArray class]])
			{
				NSLog(@"ERROR: Attempt to index into an object that is not a NSDictionary or an NSArray. Path was %@",path);
				return nil;
			}
			
			// It's an array, so try to get the index
			int index = [comp intValue];
			if (index < 0) 
			{
				NSLog(@"ERROR: Attempt to index into an array with a negative value of %d at path %@",index, path);
				return nil;
			}
			
			if (index >= [tree count])
			{
				NSLog(@"ERROR: Array index %d is greater than bounds %d at path %@", index, [tree count], path);
				return nil;
			}
			
			// Looks like it should work
			tree = [tree objectAtIndex:index];
			continue;
		}
		
		tree = [tree valueForKey:comp];
	}
	
	return tree;
}

-(NSString*) stringWithPath:(NSString*)path defaultValue:(NSString*)def 
{
	id value = [self objectAtPath:path];
	
	if (!value) return def;
	
	if ([value isKindOfClass:[NSString class]]) return value;
	return [value description];
}

-(int) intWithPath:(NSString*)path defaultValue:(int)def 
{
	id value = [self objectAtPath:path];
	
	if (!value) return def;
	
	if ([value respondsToSelector:@selector(intValue)])
	{
		return [value intValue];
	}
	
	// Aack!
	return def;
}

-(NSDate*) dateWithPath:(NSString*)path defaultValue:(NSDate*)def
{
	static NSDateFormatter* gDateParser;
	
	
	id value = [self objectAtPath:path];
	
	if (!value) return def;
	
	if ([value isKindOfClass:[NSDate class]]) return value;

	if ([value isKindOfClass:[NSString class]])
	{
		// Try to make it into a date by parsing it
		if (!gDateParser)
		{
			gDateParser = [[NSDateFormatter alloc] init];
			
			// Configure it?
			// Example timestamp = 2011-01-02T08:01:01.000Z
			[gDateParser setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
		}
				
		NSDate* ret = [gDateParser dateFromString:(NSString*)value];
		
		if (!ret) return def;
		return ret;
	}
	
	// Aack!
	return def;
}

-(NSNumber*) intNumberWithPath:(NSString*)path defaultValue:(NSNumber*)def
{
	id value = [self objectAtPath:path];
	
	if (!value) return def;
	
	if ([value isKindOfClass:[NSNumber class]]) return value;
	
	if ([value isKindOfClass:[NSString class]])
	{
		return [NSNumber numberWithLongLong:[value longLongValue]];
	}
	
	// Dunno
	return def;
}

-(NSNumber*) doubleNumberWithPath:(NSString*)path defaultValue:(NSNumber*)def
{
	id value = [self objectAtPath:path];
	
	if (!value) return def;
	
	if ([value isKindOfClass:[NSNumber class]]) return value;
	
	if ([value isKindOfClass:[NSString class]])
	{
		return [NSNumber numberWithDouble:[value doubleValue]];
	}
	
	// Dunno
	return def;
}

@end
