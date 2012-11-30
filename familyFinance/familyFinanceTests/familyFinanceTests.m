//
//  familyFinanceTests.m
//  familyFinanceTests
//
//  Created by Denis Redozubov on 28.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "familyFinanceTests.h"

@implementation familyFinanceTests

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
    
    [super tearDown];
}

- (void)testThatEnvironmentWorks
{
    STAssertNotNil(store, @"no persistent store");
}

- (void)testInsertCurrency
{

    STAssertNoThrow(1, @"insert currency");
}

@end
