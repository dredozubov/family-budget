//
//  Expense+Writer.m
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Expense+Writer.h"

NSString * const EXPENSE_AMOUNT = @"amount";

@implementation Expense (Writer)

+ (void)insertWithInfo:(NSDictionary *)expenseInfo
      inManagedObjectContext:(NSManagedObjectContext *)context {
    Expense *expense = nil;
    
    expense = [NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:context];
    expense.amount = [expenseInfo objectForKey:EXPENSE_AMOUNT];

    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new Expense: %@, %@", error, [error userInfo]);
        abort();
    }

}


@end
