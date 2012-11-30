//
//  ExpenseComment+Writer.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseComment+Writer.h"

NSString * const EXPENSE_COMMENT_TEXT = @"text";
NSString * const EXPENSE_COMMENT_CATEGORY = @"category";

@implementation ExpenseComment (Writer)

+ (void)insertWithInfo:(NSDictionary *)ExpenseCommentInfo
             inManagedObjectContext:(NSManagedObjectContext *)context {
    ExpenseComment *ExpenseComment = nil;
    
    ExpenseComment = [NSEntityDescription insertNewObjectForEntityForName:@"ExpenseComment" inManagedObjectContext:context];
    ExpenseComment.text = [ExpenseCommentInfo objectForKey:EXPENSE_COMMENT_TEXT];
    ExpenseComment.category = [ExpenseCommentInfo objectForKey:EXPENSE_COMMENT_CATEGORY];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new ExpenseComment: %@, %@", error, [error userInfo]);
        abort();
    }

}


@end