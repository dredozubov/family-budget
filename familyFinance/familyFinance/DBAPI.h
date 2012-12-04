//
//  DBAPI.h
//  familyFinance
//
//  Created by Denis Redozubov on 04.12.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAPI : NSObject
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!                                                                                !!
// !!  All object inherited from this class must by named as                         !!
// !!  <corresponding Entity>+"API"                                                  !!
// !!                                                                                !!
// !!  This realization is NOT thread-safe, for threaded background tasks queries    !!
// !!   should use different context                                                 !!
// !!                                                                                !!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// this realization is NOT thread-safe, for threaded background tasks queries should use different context

@property (nonatomic, strong) NSManagedObjectContext *context;


- (id)initWithContext:(NSManagedObjectContext *)context;
- (NSArray *)findAll;
- (NSArray *)findAllAndSortBy:(NSSortDescriptor *)sortDescriptor;

@end