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
    expenseCategory.rating = 0;
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new ExpenseCategory: %@, %@", error, [error userInfo]);
        abort();
    }
}

+ (NSArray *)getAllInManagedContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ExpenseCategory"];
    //    request.predicate = [NSPredicate predicateWithFormat:@"]
    request.predicate = nil;
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rating" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *records = [context executeFetchRequest:request error:&error];
    
    return records;
}

@end
