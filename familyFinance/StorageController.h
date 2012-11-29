//
//  StorageController.h
//  familyFinance
//
//  Created by Denis Redozubov on 29.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageController : NSObject {
  NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
