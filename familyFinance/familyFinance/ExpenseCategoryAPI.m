//
//  ExpenseCategoryAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseCategoryAPI.h"

NSString * const EXPENSE_CATEGORY_NAME = @"name";
NSString * const EXPENSE_CATEGORY_IMAGE_DATA = @"image";

@implementation ExpenseCategoryAPI

- (void)insertWithName:(NSString *)name {
    ExpenseCategory *expenseCategory = nil;
        
    expenseCategory = [NSEntityDescription insertNewObjectForEntityForName:@"ExpenseCategory" inManagedObjectContext:self.context];
    expenseCategory.name = name;
    expenseCategory.rating = 0;
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Error while inserting new ExpenseCategory: %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
