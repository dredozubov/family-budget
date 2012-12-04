//
//  familyFinanceTests.m
//  familyFinanceTests
//
//  Created by Denis Redozubov on 28.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "coreDataInMemoryTests.h"
#import "ExpenseComment+Writer.h"
#import "ExpenseCategory+Writer.h"


@implementation coreDataInMemoryTests

- (void)setUp
{
    [super setUp];
    model = [NSManagedObjectModel mergedModelFromBundles: nil];
    NSLog(@"model: %@", model);
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: model];
    store = [coordinator addPersistentStoreWithType: NSInMemoryStoreType
                                configuration: nil
                                          URL: nil
                                      options: nil
                                        error: NULL];
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator: coordinator];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
//    NSError *error = nil;
//    STAssertTrue([coordinator removePersistentStore: store error: &error], @"couldn't remove persistent store: %@", error);
//    store = nil;
    [super tearDown];
}

- (void)testThatEnvironmentWorks
{
    STAssertNotNil(store, @"no persistent store");
}

//- (void)testInsertCurrencyOK
//{
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                          @"my very first test comment", @"text",
//                          nil];
//    STAssertNoThrow([ExpenseComment insertWithInfo:dict inManagedObjectContext:context], @"insert currency OK");
//}

//- (void)testInsertCurrencyBrokenDictFAIL
//{
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
//                          @"my very first test comment", @"failedkey",
//                          nil];
//    STAssertThrows([ExpenseComment insertWithInfo:dict inManagedObjectContext:context], @"insert currency FAILED");
//}

- (void)testInsertExpenseCategoryOK
{
    NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"food", @"name",
                          nil];
    [ExpenseCategory insertWithInfo:dict1 inManagedObjectContext:context];
    NSDictionary *dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"home", @"name",
                           nil];
    [ExpenseCategory insertWithInfo:dict2 inManagedObjectContext:context];
    NSArray *results = [ExpenseCategory getAllInManagedContext:context];
    
    NSLog(@"-----------");
    NSLog(@"%@", results);
    NSLog(@"-----------");

    STAssertTrue([results count] == 2, @"ExpenseCategory insert and select");
}


@end
