//
//  DatabaseWriter.m
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "DatabaseWriter.h"
#import "CurrencyAPI.h"
#import "CommentAPI.h"
#import "CategoryAPI.h"
#import "TransactionAPI.h"

@implementation DatabaseWriter
 
@synthesize document = _document;
@synthesize ready = _ready;


- (id)init {
    // for use in ViewWillAppear()
    if (self = [super init]) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory: NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent: @"FinanceDB"];
        self.document = [[UIManagedDocument alloc] initWithFileURL: url];
        self.category = [[CategoryAPI alloc] initWithContext:self.context];
        self.comment = [[CommentAPI alloc] initWithContext:self.context];
        self.currency = [[CurrencyAPI alloc] initWithContext:self.context];
        self.transaction = [[TransactionAPI alloc] initWithContext:self.context];
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


- (void)fetchInitialDataIntoDocument
{
    dispatch_queue_t fetchQ = dispatch_queue_create("DB", NULL);
    // reading our initial data storage in another thread
    dispatch_async(fetchQ, ^{
        NSLog(@"Prepopulating Database!");
        
        
        // TODO: change it to YAML of JSON fixture
        // gigantic coded fixture
        NSArray *currencies = [NSArray arrayWithObjects:
                               [NSDictionary dictionaryWithObjectsAndKeys:
                                @"RUB", @"code",nil],
                               [NSDictionary dictionaryWithObjectsAndKeys:
                                @"USD", @"code",nil],
                               nil];
        
        NSArray *Categories = [NSArray arrayWithObjects:
                                      [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"food", @"name",
                                       0, @"rating", nil],
                                      [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"health", @"name",
                                       0, @"rating", nil],
                                      [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"personal use", @"name",
                                       0, @"rating", nil],
                                      nil];
        
        // relations
        // TODO: doesn't work, change to fetched NSManagedObjects
        Category *foodCategory =
            [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.context];
        foodCategory.name = @"food";
        foodCategory.rating = 0;
        
        Category *personalCategory =
        [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.context];
        personalCategory.name = @"personal use";
        personalCategory.rating = 0;
        
        Currency *usdCurrency =
            [NSEntityDescription insertNewObjectForEntityForName:@"Currency" inManagedObjectContext:self.context];
        usdCurrency.code = @"USD";
        
//        Comment *familyfinanceComment =
//            [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.context];
//        familyfinanceComment.text = @"this very software!";
//        familyfinanceComment.rating = 0;
//        familyfinanceComment.category = personalCategory;

        // end

        NSArray *Comments = [NSArray arrayWithObjects:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"coffeeshop", @"text",
                                     0, @"rating",
                                     foodCategory, @"category",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"mall", @"text",
                                     0, @"rating",
                                     foodCategory, @"category",
                                     nil],
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"software", @"text",
                                     0, @"rating",
                                     personalCategory, @"category",
                                     nil],

                                    nil];
        
//        NSArray *transactions = [NSArray arrayWithObjects:
//                             [NSDictionary dictionaryWithObjectsAndKeys:
//                              [NSNumber numberWithDouble:5.0], @"amount",
//                              [NSDate date], @"added_on",
//                              personalCategory, @"category",
//                              usdCurrency, @"currency",
//                              familyfinanceComment, @"comment",
//                              nil],
//                             nil];
        
//        NSArray *data = [NSArray arrayWithObjects:
//                         currencies, Categories, Comments,
//                         nil];
        
        // core data manipulations must be made in thread with context, so...
        [self.document.managedObjectContext performBlock:^{
            for (id cur in currencies) {
                [self.currency insertWithDict:cur];
            }
            for (id cat in Categories) {
                [self.category insertWithDict:cat];
            }
            for (id com in Comments) {
                [self.comment insertWithDict:com];
            }
            NSLog(@"comments are: %@", [self.comment findAll]);
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
                // db don't exist, it's THE place to populate it with initial data
                [self fetchInitialDataIntoDocument];
                [self documentIsReady];
            } else
            {
                NSLog(@"couldn't open document at %@", url);
            }
        }];
    } else if (self.document.documentState == UIDocumentStateClosed) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            // error handling
            [self documentIsReady];
            NSLog(@"logging: UIDocumentStateClosed");
            NSLog(@"opened after completionHandler: %d", self.document.documentState == UIDocumentStateNormal);
        }];
    } else if (self.document.documentState == UIDocumentStateNormal) {
        [self documentIsReady];
        NSLog(@"DatabaseWriter OK");
    }
}

- (void)setDocument:(UIManagedDocument *)fDatabase {
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
