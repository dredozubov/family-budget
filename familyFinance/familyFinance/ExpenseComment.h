//
//  ExpenseComment.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExpenseCategory;

@interface ExpenseComment : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) ExpenseCategory *category;

@end
