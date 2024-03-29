//
//  Expense.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Currency;

@interface Expense : NSManagedObject

@property (nonatomic, retain) NSDate * added_on;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) Currency *currency;
@property (nonatomic, retain) NSManagedObject *comment;

@end
