//
//  TransactionTestCase.m
//  familyFinance
//
//  Created by Denis Redozubov on 11.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "TransactionTestCase.h"
#import "CurrencyAPI.h"
#import <Coredata/CoreData.h>

@implementation TransactionTestCase
@synthesize context;

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

//- (void)testDBAPISubClassing
//{
//    CategoryAPI *category = [[CategoryAPI alloc] initWithContext:context];
//    NSArray *results = [category findAll];
//    GHAssertTrue([results count] == 0, @"DBAPI Subclassing", nil);
//}

- (void)testCurrencyInsert
{
    CurrencyAPI *currency = [[CurrencyAPI alloc] initWithContext:self.context];
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"USD", @"code",
                          [NSDecimalNumber numberWithFloat:1.0], @"dollar_relation", nil];
    GHAssertNoThrow([currency insertWithDict:data],
                    @"unable to insert new currency");
}



@end
