//
//  ExpenseViewController.h
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate>

- (IBAction)selectCategory:(UIButton *)sender;
- (IBAction)addExpense:(UIButton *)sender;
- (IBAction)saveCategory:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *expenseTextField;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIView *categoryViewContainer;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@end
