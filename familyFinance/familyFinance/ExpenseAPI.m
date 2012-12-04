//
//  ExpenseAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseAPI.h"

NSString * const EXPENSE_AMOUNT = @"amount";

@implementation ExpenseAPI

- (void)insertWithInfo:(NSDictionary *)expenseInfo
{
    Expense *expense = nil;
    
    expense = [NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:self.context];
    expense.amount = [expenseInfo objectForKey:EXPENSE_AMOUNT];

    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Error while inserting new Expense: %@, %@", error, [error userInfo]);
        abort();
    }

}

@end