//
//  TransactionTestCase.h
//  familyFinance
//
//  Created by Denis Redozubov on 11.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "DatabaseWriter.h"

@interface TransactionTestCase : GHTestCase

@property (nonatomic, retain) NSManagedObjectContext *context;

@end
