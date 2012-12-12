//
//  familyFinanceTests.m
//  familyFinanceTests
//
//  Created by Denis Redozubov on 28.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "coreDataInMemoryTests.h"
#import "CategoryAPI.h"


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

- (void)testDBAPISubClassing
{
    CategoryAPI *category = [[CategoryAPI alloc] initWithContext:context];
    NSArray *results = [category findAll];
    NSAssert1([results count] == 0, @"DBAPI Subclassing", nil);
    NSLog(@"Results: %@", results);
}

@end
