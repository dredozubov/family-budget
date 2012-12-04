//
//  ExpenseComment.h
//  familyFinance
//
//  Created by Denis Redozubov on 04.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expense, ExpenseCategory;

@interface ExpenseComment : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *category;
@property (nonatomic, retain) NSSet *expense;
@end

@interface ExpenseComment (CoreDataGeneratedAccessors)

- (void)addCategoryObject:(ExpenseCategory *)value;
- (void)removeCategoryObject:(ExpenseCategory *)value;
- (void)addCategory:(NSSet *)values;
- (void)removeCategory:(NSSet *)values;

- (void)addExpenseObject:(Expense *)value;
- (void)removeExpenseObject:(Expense *)value;
- (void)addExpense:(NSSet *)values;
- (void)removeExpense:(NSSet *)values;

@end
