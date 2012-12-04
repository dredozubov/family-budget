//
//  Currency+Writer.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Currency+Writer.h"

@implementation Currency (Writer)

+ (void)insertWithCode:(NSString *)code
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    Currency *currency = nil;
    
    currency = [NSEntityDescription insertNewObjectForEntityForName:@"Currency" inManagedObjectContext:context];
    currency.code = code;
    
}

@end