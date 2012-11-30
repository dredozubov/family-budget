//
//  ExpenseWriter.m
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "DatabaseWriter.h"
#import "Expense.h"
#import "ExpenseComment.h"
#import "ExpenseCategory.h"

@implementation DatabaseWriter
@synthesize financeDatabase = _financeDatabase;

- (void)setupStorageController {
    //setupStorageController
}

- (void)fetchInitialDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("DB fetcher", NULL);
    dispatch_async(fetchQ, ^{
        // reading initial fixtures
        NSArray *data = nil;
        
        [document.managedObjectContext performBlock:^{
            for (NSArray *table in data) {
                // start creating objects in document's context
            }
        }];
    });
    dispatch_release(fetchQ);
}

- (void)useDocument {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.financeDatabase.fileURL path]]) {
        [self.financeDatabase saveToURL:self.financeDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
              // db don't exist, it's THE place to populate it with initial data
        }];
    } else if (self.financeDatabase.documentState == UIDocumentStateClosed) {
        [self.financeDatabase openWithCompletionHandler:^(BOOL success) {
            // error handling
        }];
    } else if (self.financeDatabase.documentState == UIDocumentStateNormal) {
        // final setup, everything is ok
    }
}

- (void)setDatabase:(UIManagedDocument *)fDatabase {
    if (_financeDatabase != fDatabase) {
        _financeDatabase = fDatabase;
        [self useDocument];
    }
}

- (id)initDB {
    // for use in ViewWillAppear()
    if (self = [super init]) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent: @"FinanceDB"];
        self.financeDatabase = [[UIManagedDocument alloc] initWithFileURL: url];
    }
    return self;
}

@end
