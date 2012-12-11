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

- (Currency *)findByCode:(NSString *)code
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Currency" inManagedObjectContext:self.context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *foodPredicate = [NSPredicate predicateWithFormat:@"(code ==[c] %@)", code];
    [request setEntity:entityDescription];
    [request setPredicate:foodPredicate];
    
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"unable to findByCode with code = %@:%@", code, error);
        abort();
    }
    if ([array count] > 1) {
        NSLog(@"duplicated values in findByCode with text = %@", code);
        abort();
    }
    return [array objectAtIndex:0];
}

@end