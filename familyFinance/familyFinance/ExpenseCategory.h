//
//  ExpenseCategory.h
//  familyFinance
//
//  Created by Denis Redozubov on 04.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expense, ExpenseComment;

@interface ExpenseCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) NSSet *expense;
@end

@interface ExpenseCategory (CoreDataGeneratedAccessors)

- (void)addCommentObject:(ExpenseComment *)value;
- (void)removeCommentObject:(ExpenseComment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

- (void)addExpenseObject:(Expense *)value;
- (void)removeExpenseObject:(Expense *)value;
- (void)addExpense:(NSSet *)values;
- (void)removeExpense:(NSSet *)values;

@end
