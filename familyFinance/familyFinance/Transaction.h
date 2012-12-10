//
//  Transaction.h
//  familyFinance
//
//  Created by Denis Redozubov on 10.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Comment, Currency;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDate * added_on;
@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) Comment *comment;
@property (nonatomic, retain) Currency *currency;

@end
