//
//  ExpenseCategory+Writer.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseCategory.h"

extern NSString * const EXPENSE_CATEGORY_NAME;
extern NSString * const EXPENSE_CATEGORY_IMAGE_DATA;

@interface ExpenseCategory (Writer)

+ (void)insertWithInfo:(NSDictionary *)expenseCategoryInfo
      inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)getAllInManagedContext:(NSManagedObjectContext *)context;

@end
