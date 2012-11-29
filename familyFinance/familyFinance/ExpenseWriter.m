//
//  ExpenseWriter.m
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseWriter.h"
#import "Expense.h"
#import "ExpenseComment.h"
#import "ExpenseCategory.h"

@implementation ExpenseWriter
@synthesize financeDatabase = _financeDatabase;

- (void)setupStorageController {
    //setupStorageController
}

- (void)useDocument {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.financeDatabase.fileURL path]]) {
        [self.financeDatabase saveToURL:self.financeDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
             [self setupStorageController];
        }];
    } else if (self.financeDatabase.documentState == UIDocumentStateClosed) {
        [self.financeDatabase openWithCompletionHandler:^(BOOL success) {
            [self setupStorageController];
        }];
    } else if (self.financeDatabase.documentState == UIDocumentStateNormal) {
        [self setupStorageController];
    }
}

- (void)setDatabase:(UIManagedDocument *)fDatabase {
    if (_financeDatabase != fDatabase) {
        _financeDatabase = fDatabase;
        [self useDocument];
    }
}

- (id)initNew {
    // for use in ViewWillAppear()
    if (self = [super init]) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent: @"FinanceDB"];
        self.financeDatabase = [[UIManagedDocument alloc] initWithFileURL: url];
    }
    return self;
}

@end
