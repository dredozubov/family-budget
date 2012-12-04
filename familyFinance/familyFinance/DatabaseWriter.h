//
//  ExpenseWriter.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expense.h"

@interface DatabaseWriter : NSObject {
    UIManagedDocument *financeDatabase;
}

- (id)initDB;
- (id)getExpenseCommentByText:(NSString *)text;
- (id)getExpenseCategoryByName:(NSString *)name;
- (id)getCurrencyByCode:(NSString *)code;
- (void)insertExpenseCategoryWithName:(NSString *)name;
- (NSManagedObjectContext *)context;
- (NSArray *)getAllExpenses;
- (NSArray *)getAllExpenseComments;
- (NSArray *)getAllExpenseCategories;


@property (nonatomic, retain) UIManagedDocument *financeDatabase;

@end
