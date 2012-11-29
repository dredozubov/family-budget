//
//  familyFinanceTests.h
//  familyFinanceTests
//
//  Created by Denis Redozubov on 28.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface familyFinanceTests : SenTestCase

@end

@interface MyTest : SenTestCase {
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
}
@end

