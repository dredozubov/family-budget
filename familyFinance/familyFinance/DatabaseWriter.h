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
#import "TransactionAPI.h"

@interface DatabaseWriter : NSObject {
    UIManagedDocument *document;
}

- (id)init;
- (NSManagedObjectContext *)context;

@property (nonatomic, retain) UIManagedDocument *document;

@property (nonatomic) BOOL ready;

@property (nonatomic, retain) TransactionAPI *transaction;
@property (nonatomic, retain) CommentAPI *comment;
@property (nonatomic, retain) CategoryAPI *category;
@property (nonatomic, retain) CurrencyAPI *currency;

@end