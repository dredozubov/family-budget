//
//  ExpenseCommentAPI.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Comment.h"
#import "DBAPI.h"

extern NSString * const EXPENSE_COMMENT_TEXT;
extern NSString * const EXPENSE_COMMENT_CATEGORY;

@interface CommentAPI: DBAPI

- (Comment *)findByText:(NSString *)text;

@end

