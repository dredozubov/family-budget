//
//  ExpenseCategory+Writer.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseCategory+Writer.h"

NSString * const EXPENSE_CATEGORY_NAME = @"name";
NSString * const EXPENSE_CATEGORY_IMAGE_DATA = @"image";

@implementation ExpenseCategory (Writer)

+ (void)insertWithInfo:(NSDictionary *)expenseCategoryInfo
      inManagedObjectContext:(NSManagedObjectContext *)context {
    ExpenseCategory *expenseCategory = nil;
        
    expenseCategory = [NSEntityDescription insertNewObjectForEntityForName:@"ExpenseCategory" inManagedObjectContext:context];
    expenseCategory.name = [expenseCategoryInfo objectForKey:EXPENSE_CATEGORY_NAME];
    expenseCategory.image = [expenseCategoryInfo objectForKey:EXPENSE_CATEGORY_IMAGE_DATA];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new ExpenseCategory: %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
