//
//  Comment.h
//  familyFinance
//
//  Created by Denis Redozubov on 10.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Ledger;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSSet *category;
@property (nonatomic, retain) NSSet *ledger;
@end

@interface Comment (CoreDataGeneratedAccessors)

- (void)addCategoryObject:(Category *)value;
- (void)removeCategoryObject:(Category *)value;
- (void)addCategory:(NSSet *)values;
- (void)removeCategory:(NSSet *)values;

- (void)addLedgerObject:(Ledger *)value;
- (void)removeLedgerObject:(Ledger *)value;
- (void)addLedger:(NSSet *)values;
- (void)removeLedger:(NSSet *)values;

@end
