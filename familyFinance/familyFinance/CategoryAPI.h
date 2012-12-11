//
//  ExpenseCategoryAPI.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Category.h"
#import "DBAPI.h"

extern NSString * const EXPENSE_CATEGORY_NAME;
extern NSString * const EXPENSE_CATEGORY_IMAGE_DATA;

@interface CategoryAPI: DBAPI

- (void)insertWithName:(NSString *)name;
- (Category *)findByName:(NSString *)name;

@end
