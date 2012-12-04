//
//  ExpenseCommentAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseCommentAPI.h"

NSString * const EXPENSE_COMMENT_TEXT = @"text";
NSString * const EXPENSE_COMMENT_CATEGORY = @"category";

@implementation ExpenseCommentAPI

- (void)insertWithInfo:(NSDictionary *)expenseCommentInfo
{
    [self insertWithInfo:expenseCommentInfo inManagedObjectContext:self.context];
}

- (void)insertWithInfo:(NSDictionary *)expenseCommentInfo inManagedObjectContext:(NSManagedObjectContext *)context
{
    ExpenseComment *expenseComment = nil;
    
    expenseComment = [NSEntityDescription insertNewObjectForEntityForName:@"ExpenseComment" inManagedObjectContext:context];
    for (NSString *key in expenseCommentInfo) {
        [expenseComment setValue:[expenseCommentInfo objectForKey:key] forKey:key];
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new ExpenseComment: %@, %@", error, [error userInfo]);
        abort();
    }

}


@end