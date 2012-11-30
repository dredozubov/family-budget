//
//  ExpenseWriter.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expense.h"

@interface DatabaseWriter : NSObject {
    UIManagedDocument *financeDatabase;
}

- (id)initDB;


@property (nonatomic, retain) UIManagedDocument *financeDatabase;

@end
