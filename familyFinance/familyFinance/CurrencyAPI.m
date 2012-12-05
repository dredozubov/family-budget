//
//  CurrencyAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "CurrencyAPI.h"

NSString * const CURRENCY_CODE = @"code";

@implementation CurrencyAPI

- (void)insertWithCode:(NSString *)code
{
    Currency *currency = nil;
    
    currency = [NSEntityDescription insertNewObjectForEntityForName:@"Currency" inManagedObjectContext:self.context];
    currency.code = code;
   
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Error while inserting new Currency: %@, %@", error, [error userInfo]);
        abort();
    }
}

@end