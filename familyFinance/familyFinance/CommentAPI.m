//
//  ExpenseCommentAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "CommentAPI.h"

NSString * const EXPENSE_COMMENT_TEXT = @"text";
NSString * const EXPENSE_COMMENT_CATEGORY = @"category";

@implementation CommentAPI

- (Comment *)findByText:(NSString *)text
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Comment" inManagedObjectContext:self.context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSPredicate *foodPredicate = [NSPredicate predicateWithFormat:@"(text ==[c] %@)", text];
    [request setEntity:entityDescription];
    [request setPredicate:foodPredicate];
    
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"unable to findByText with text = %@:%@", text, error);
        abort();
    }
    if ([array count] > 1) {
        NSLog(@"duplicated values in findByText with text = %@", text);
        abort();
    }
    return [array objectAtIndex:0];
}


@end