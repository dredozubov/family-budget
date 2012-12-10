//
//  ExpenseWriter.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentAPI.h"
#import "CategoryAPI.h"
#import "CurrencyAPI.h"

@interface DatabaseWriter : NSObject {
    UIManagedDocument *document;
}

- (id)init;
- (NSManagedObjectContext *)context;
//- (id)getExpenseCommentByText:(NSString *)text;
//- (id)getExpenseCategoryByName:(NSString *)name;
//- (id)getCurrencyByCode:(NSString *)code;



@property (nonatomic, retain) UIManagedDocument *document;

@property (nonatomic) BOOL ready;

//@property (nonatomic, retain) ExpenseAPI *expense;
@property (nonatomic, retain) CommentAPI *expenseComment;
@property (nonatomic, retain) CategoryAPI *expenseCategory;
@property (nonatomic, retain) CurrencyAPI *currency;

@end