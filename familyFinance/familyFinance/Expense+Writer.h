//
//  Expense+Writer.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Expense.h"

extern NSString * const EXPENSE_AMOUNT;

@interface Expense (Writer)

+ (void)insertWithInfo:(NSDictionary *)expenseInfo
      inManagedObjectContext:(NSManagedObjectContext *)context;

@end
