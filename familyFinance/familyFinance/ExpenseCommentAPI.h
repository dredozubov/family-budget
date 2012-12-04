//
//  ExpenseCommentAPI.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseComment.h"
#import "DBAPI.h"

extern NSString * const EXPENSE_COMMENT_TEXT;
extern NSString * const EXPENSE_COMMENT_CATEGORY;

@interface ExpenseCommentAPI: DBAPI

- (void)insertWithInfo:(NSDictionary *)expenseCommentInfo;
- (void)insertWithInfo:(NSDictionary *)expenseCommentInfo inManagedObjectContext:context;

@end

