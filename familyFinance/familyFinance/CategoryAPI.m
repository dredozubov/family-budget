//
//  ExpenseCategoryAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "CategoryAPI.h"

NSString * const CATEGORY_NAME = @"name";
NSString * const CATEGORY_IMAGE_DATA = @"image";

@implementation CategoryAPI

- (void)insertWithName:(NSString *)name {
    Category *category = nil;
        
    category = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.context];
    category.name = name;
    category.rating = 0;
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Error while inserting new Category: %@, %@", error, [error userInfo]);
        abort();
    }
}

@end
