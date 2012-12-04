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

- (void)insertWithInfo:(NSDictionary *)currencyInfo
{
    [self insertWithInfo:currencyInfo inManagedObjectContext:self.context];
}

- (void)insertWithInfo:(NSDictionary *)currencyInfo inManagedObjectContext:(id)context
{
    Currency *currency = nil;
    
    currency = [NSEntityDescription insertNewObjectForEntityForName:@"Currency" inManagedObjectContext:self.context];
    currency.code = [currencyInfo objectForKey:CURRENCY_CODE];
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Error while inserting new Currency: %@, %@", error, [error userInfo]);
        abort();
    }
}

@end