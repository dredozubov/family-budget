//
//  TransactionTestCase.m
//  familyFinance
//
//  Created by Denis Redozubov on 11.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "DBModelsAPITestCase.h"
#import "CurrencyAPI.h"
#import "CategoryAPI.h"
#import "CommentAPI.h"
#import "TransactionAPI.h"
#import <Coredata/CoreData.h>

@implementation DBModelsAPITestCase
@synthesize context;

#pragma mark -
#pragma mark - Housekeeping 

- (BOOL)shouldRunOnMainThread
{
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return NO;
}

// Run at start of all tests in the class
- (void)setUpClass
{
    [super setUp];
    NSArray *bundles = [NSBundle allBundles];
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:bundles];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSPersistentStore *store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    GHAssertNotNil(store, @"Unable to create in-memory store");

    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [self.context setPersistentStoreCoordinator:coordinator];

}

// Run at end of all tests in the class
- (void)tearDownClass
{
    [super tearDownClass];
    self.context = nil;
}

// Run before each test method
- (void)setUp
{
}

// Run after each test method
- (void)tearDown
{
}

#pragma mark -
#pragma mark Unit Tests

- (void)test01Currency
{
    CurrencyAPI *currency = [[CurrencyAPI alloc] initWithContext:self.context];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"USD", @"code",
                          [NSDecimalNumber numberWithFloat:1.0], @"dollar_relation", nil];
    GHAssertNoThrow([currency insertWithDict:data],
                    @"unable to insert new currency");
    GHAssertTrue([[currency findAll] count] == 1, @"unable to select currencies");
    NSDictionary *data2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"RUB", @"code",
                           [NSDecimalNumber numberWithFloat:30.0], @"dollar_relation", nil];
    GHAssertNoThrow([currency insertWithDict:data2],
                    @"unable to insert new currency repeatedly");
    NSArray *fetched = [currency findAll];
    GHAssertTrue([[currency findAll] count] == 2, @"select count from currencies is wrong: %@", fetched);
}

- (void)test02Category
{
    CategoryAPI *category = [[CategoryAPI alloc] initWithContext:self.context];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"food", @"name",
                          0, @"rating", nil];
    GHAssertNoThrow([category insertWithDict:data], @"unable to insert category");
    GHAssertTrue([[category findAll] count] == 1, @"unable to select categories");
    NSDictionary *data2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"health", @"name",
                           0, @"rating", nil];
    GHAssertNoThrow([category insertWithDict:data2],
                    @"unable to insert new category repeatedly");
    NSArray *fetched = [category findAll];
    GHAssertTrue([[category findAll] count] == 2, @"select count from categories is wrong: %@", fetched);
}

- (void)test03Comment
{
    CommentAPI *comment = [[CommentAPI alloc] initWithContext:self.context];
    
    CategoryAPI *category = [[CategoryAPI alloc] initWithContext:self.context];
    GHAssertTrue([[category findAll] count] == 2, @"unable to retrieve categories from previous test");
    
    Category *foodCategory = [category findByName:@"food"];
    GHAssertNotNil(foodCategory, @"unable to retrieve category with name 'foo'");
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"restaraunt", @"text",
                          foodCategory, @"category",
                          0, @"rating", nil];
    GHAssertNoThrow([comment insertWithDict:data], @"unable to insert comment");
    GHAssertTrue([[comment findAll] count] == 1, @"unable to select comments");
    NSDictionary *data2 = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"food for home", @"text",
                           foodCategory, @"category",
                           0, @"rating", nil];
     GHAssertNoThrow([comment insertWithDict:data2],
                    @"unable to insert new category repeatedly");
    NSArray *fetched = [comment findAll];
    GHAssertTrue([[comment findAll] count] == 2, @"select count from categories is wrong: %@", fetched);
}

- (void)test04Transaction
{
    TransactionAPI *transaction = [[TransactionAPI alloc] initWithContext:self.context];
    CategoryAPI *category = [[CategoryAPI alloc] initWithContext:self.context];
    CommentAPI *comment = [[CommentAPI alloc] initWithContext:self.context];
    CurrencyAPI *currency = [[CurrencyAPI alloc] initWithContext:self.context];
    
    GHAssertTrue([[category findAll] count] == 2, @"unable to retrieve categories from previous test");
    GHAssertTrue([[comment findAll] count] == 2, @"unable to retrieve comments from previous test");
    GHAssertTrue([[currency findAll] count] == 2, @"unable to retrieve currencies from previous test");
    
    Category *foodCategory = [category findByName:@"food"];
    GHTestLog(@"%@", foodCategory);
    GHAssertNotNil(foodCategory, @"unable to retrieve category with name 'food'");

    Comment *restarauntComment = [comment findByText:@"restaraunt"];
    GHTestLog(@"%@", restarauntComment);
    GHAssertNotNil(foodCategory, @"unable to retrieve category with text 'restaraunt'");
    
    Currency *usdCurrency = [currency findByCode:@"USD"];
    GHTestLog(@"%@", usdCurrency);
    GHAssertNotNil(usdCurrency, @"unable to retrieve currency with code 'USD'");
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          usdCurrency, @"currency",
                          foodCategory, @"category",
                          restarauntComment, @"comment",
                          [NSDate date], @"added_on",
                          [NSDecimalNumber numberWithInt:1000], @"amount",
                          0, @"type",
                          nil];
    GHAssertNoThrow([transaction insertWithDict:data], @"unable to insert comment");
    GHAssertTrue([[transaction findAll] count] == 1, @"unable to select comments");
}

@end
