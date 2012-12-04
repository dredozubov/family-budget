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
    // reading our initial data storage in another thread
    dispatch_async(fetchQ, ^{
        // reading initial fixtures
        NSArray *data = nil;
        
        // core data manipulations must be made in thread with context, so...
        [document.managedObjectContext performBlock:^{
            for (NSArray *table in data) {
                // start creating objects in document's context
            }
        }];
    });
    
    // removing this is safe for IOS 6 in ARC mode
    // dispatch_release(fetchQ);
}

- (void)useDocument {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.financeDatabase.fileURL path]]) {
        [self.financeDatabase saveToURL:self.financeDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
              // db don't exist, it's THE place to populate it with initial data
            NSLog(@"don't exist");
        }];
    } else if (self.financeDatabase.documentState == UIDocumentStateClosed) {
        [self.financeDatabase openWithCompletionHandler:^(BOOL success) {
            // error handling
            NSLog(@"logging error in DatabaseWriter");
        }];
    } else if (self.financeDatabase.documentState == UIDocumentStateNormal) {
        // final setup, everything is ok
        NSLog(@"DatabaseWriter OK");
    }
}

- (void)setFinanceDatabase:(UIManagedDocument *)fDatabase {
    if (_financeDatabase != fDatabase) {
        _financeDatabase = fDatabase;
        [self useDocument];
    }
}

- (NSManagedObjectContext *)context
{
    return self.financeDatabase.managedObjectContext;
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

//
// queries API
//

- (void)insertExpenseCategoryWithName:(NSString *)name
{
    ExpenseCategory *expenseCategory = nil;
    NSManagedObjectContext *context = self.financeDatabase.managedObjectContext;
    
    expenseCategory = [NSEntityDescription insertNewObjectForEntityForName:@"ExpenseCategory" inManagedObjectContext:context];
    expenseCategory.name = name;
//    expenseCategory.image = [NSData];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new ExpenseCategory: %@, %@", error, [error userInfo]);
        abort();
    }
}


- (NSArray *)getAllExpenseCategories
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ExpenseCategory"];
//    request.predicate = [NSPredicate predicateWithFormat:@"]
    request.predicate = nil;
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *records = [self.financeDatabase.managedObjectContext executeFetchRequest:request error:&error];
    
    return records;
}

@end
