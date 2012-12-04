//
//  ExpenseAPI.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Expense.h"
#import "DBAPI.h"

extern NSString * const EXPENSE_AMOUNT;

@interface ExpenseAPI: DBAPI

- (void)insertWithInfo:(NSDictionary *)expenseInfo;

@end
