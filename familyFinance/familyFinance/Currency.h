//
//  Currency.h
//  familyFinance
//
//  Created by Denis Redozubov on 10.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ledger;

@interface Currency : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSNumber * dollar_relation;
@property (nonatomic, retain) NSSet *ledger;
@end

@interface Currency (CoreDataGeneratedAccessors)

- (void)addLedgerObject:(Ledger *)value;
- (void)removeLedgerObject:(Ledger *)value;
- (void)addLedger:(NSSet *)values;
- (void)removeLedger:(NSSet *)values;

@end
