//
//  DBAPI.m
//  familyFinance
//
//  Created by Denis Redozubov on 04.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "DBAPI.h"
#import <CoreData/CoreData.h>

@implementation DBAPI
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!                                                                                !!
// !!  All object inherited from this class must by named as corresponding Entities  !!
// !!                                                                                !!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

@synthesize context = _context;

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        _context = context;
    }
    return self;
}


- (NSString *)getEntity
{
    NSMutableString *class = [NSMutableString stringWithString:NSStringFromClass([self class])];
    if ([class hasSuffix:@"API"])
    {
        NSUInteger len = [class length];
        [class replaceCharactersInRange:NSMakeRange(len-3, 3) withString:@""];
        return [NSString stringWithString:class];
    }
    else {
        NSLog(@"API Class '%@' doesn't have 'API' suffix", class);
        abort();
    }
}


- (NSArray *)findAll
{
    NSString *entity = [self getEntity];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    request.predicate = nil;
    
    NSError *error = nil;
    NSArray *records = [self.context executeFetchRequest:request error:&error];
    
    return records;
}


- (NSArray *)findAllAndSortBy:(NSSortDescriptor *)sortDescriptor // nil for empty sort descriptor
{
    NSString *entity = [self getEntity];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    request.predicate = nil;
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *records = [self.context executeFetchRequest:request error:&error];
    
    return records;
}


- (void)insertWithDict:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *entity = [self getEntity];
    
    id obj = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
    for (NSString *key in dict) {
        [obj setValue:[dict objectForKey:key] forKey:key];
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while inserting new ExpenseComment: %@, %@", error, [error userInfo]);
        abort();
    } else {
        NSLog(@"Add into DB: %@",[self getEntity]);
    }
}


- (void)insertWithDict:(NSDictionary *)dict
{
    [self insertWithDict:dict inManagedObjectContext:self.context];
}

@end
