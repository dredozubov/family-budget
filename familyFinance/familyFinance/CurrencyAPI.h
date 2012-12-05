//
//  CurrencyAPI.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "Currency.h"
#import "DBAPI.h"

extern NSString * const CURRENCY_CODE;

@interface CurrencyAPI: DBAPI

- (void)insertWithCode:(NSString *)code;

@end
