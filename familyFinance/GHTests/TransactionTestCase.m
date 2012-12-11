//
//  TransactionTestCase.m
//  familyFinance
//
//  Created by Denis Redozubov on 11.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "TransactionTestCase.h"

@implementation TransactionTestCase
    
// By default NO, but if you have a UI test or test dependent on running on the main thread return YES
- (BOOL)shouldRunOnMainThread
{
    return NO;
}

// Run at start of all tests in the class
- (void)setUpClass
{
}

// Run at end of all tests in the class
- (void)tearDownClass
{
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

- (void)testMyFunctionality
{
    // Your unit test code
    GHAssertTrue(false,@"Haha, I set you up to fail.");
}

@end
