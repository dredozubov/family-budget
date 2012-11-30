//
//  ExpenseComment+Writer.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseComment.h"

extern NSString * const EXPENSE_COMMENT_TEXT;
extern NSString * const EXPENSE_COMMENT_CATEGORY;

@interface ExpenseComment (Writer)

+ (void)insertWithInfo:(NSDictionary *)expenseCommentInfo
             inManagedObjectContext:(NSManagedObjectContext *)context;

@end
