//
//  ExpenseWriter.m
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "DatabaseWriter.h"
#import "CurrencyAPI.h"
#import "ExpenseCommentAPI.h"
#import "ExpenseCategoryAPI.h"

@implementation DatabaseWriter
 
@synthesize document = _document;
@synthesize ready = _ready;


- (id)init {
    // for use in ViewWillAppear()
    if (self = [super init]) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent: @"FinanceDB"];
        self.document = [[UIManagedDocument alloc] initWithFileURL: url];
        self.expenseCategory = [[ExpenseCategoryAPI alloc] initWithContext:self.context];
        self.expenseComment = [[ExpenseCommentAPI alloc] initWithContext:self.context];
        self.currency = [[CurrencyAPI alloc] initWithContext:self.context];
    }
    return self;
}

- (void)documentIsReady
{
    if (self.document.documentState == UIDocumentStateNormal) { // last line of defense
        self.ready = YES;
    } else {
        self.ready = NO;
    }

}

- (void)documentIsNotReady
{
    self.ready = NO;
}

- (void)fetchInitialDataIntoDocument:(UIManagedDocument *)document
{
    dispatch_queue_t fetchQ = dispatch_queue_create("DB fetcher", NULL);
    // reading our initial data storage in another thread
    dispatch_async(fetchQ, ^{
        // reading initial fixtures
        NSArray *data = nil;
        
        // core data manipulations must be made in thread with context, so...
        [self.document.managedObjectContext performBlock:^{
            for (NSArray *table in data) {
                // start creating objects in document's context
            }
        }];
    });
    
    // removing this is safe for IOS 6 in ARC mode
    // dispatch_release(fetchQ);
}

- (void)useDocument {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.document.fileURL path]]) {
        NSURL *url = self.document.fileURL;
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success)
            {
                [self documentIsReady];
                // db don't exist, it's THE place to populate it with initial data
            } else
            {
                NSLog(@"couldn't open document at %@", url);
            }
        }];
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            // error handling
            [self documentIsNotReady];
            NSLog(@"logging error: UIDocumentStateClosed");
        }];
    } else if (self.document.documentState == UIDocumentStateNormal) {
        [self documentIsReady];
        NSLog(@"DatabaseWriter OK");
    }
}

- (void)setdocument:(UIManagedDocument *)fDatabase {
    if (_document != fDatabase) {
        _document = fDatabase;
        [self useDocument];
    }
}

- (NSManagedObjectContext *)context
{
    return self.document.managedObjectContext;
}

@end
