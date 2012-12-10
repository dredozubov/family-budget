//
//  Category.h
//  familyFinance
//
//  Created by Denis Redozubov on 10.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Ledger;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *comment;
@property (nonatomic, retain) NSSet *ledger;
@end

@interface Category (CoreDataGeneratedAccessors)

- (void)addCommentObject:(Comment *)value;
- (void)removeCommentObject:(Comment *)value;
- (void)addComment:(NSSet *)values;
- (void)removeComment:(NSSet *)values;

- (void)addLedgerObject:(Ledger *)value;
- (void)removeLedgerObject:(Ledger *)value;
- (void)addLedger:(NSSet *)values;
- (void)removeLedger:(NSSet *)values;

@end
