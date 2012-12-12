//
//  ExpenseViewController.m
//  familyFinance
//
//  Created by Denis Redozubov on 30.11.12.
//  Copyright (c) 2012 Denis Redozubov. All rights reserved.
//

#import "ExpenseViewController.h"
#import "DatabaseWriter.h"
#import "Category.h"
#import "Comment.h"
#import "Currency.h"
#import "Transaction.h"

@interface ExpenseViewController ()

@property (strong, nonatomic) DatabaseWriter *databaseWriter;
@property (strong, nonatomic) NSArray *categoriesArray;
@property (nonatomic) NSInteger selectedCategoryIndex;

@end

@implementation ExpenseViewController

@synthesize categoryViewContainer;
@synthesize categoryPicker;
@synthesize categoryButton;
@synthesize expenseTextField;
@synthesize commentTextView;

@synthesize databaseWriter = _databaseWriter;
@synthesize categoriesArray = _categoriesArray;
@synthesize selectedCategoryIndex;

- (DatabaseWriter *) databaseWriter
{
    if (!_databaseWriter) {
        _databaseWriter = [[DatabaseWriter alloc] init];
        NSLog(@"databaseWriter");
    }
    return _databaseWriter;
}

- (NSArray *) categoriesArray
{
    if (!_categoriesArray) {
        NSLog(@"categoriesArray");
        _categoriesArray = [[self.databaseWriter category] findAll];
    }
    
    return _categoriesArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedCategoryIndex = -1;
    
    [super viewDidLoad];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    expenseTextField.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    [expenseTextField resignFirstResponder];
    expenseTextField.text = @"0.00";
}

-(void)doneWithNumberPad{
    //NSString *numberFromTheKeyboard = expenseTextField.text;
    [expenseTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectCategory:(UIButton *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    categoryViewContainer.frame = CGRectMake(0,160,320,255);
    [UIView commitAnimations];
}

- (IBAction)addExpense:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"reportSeque" sender:sender];
    
    
    if (selectedCategoryIndex == -1) return;
    

    Category *category = [self.categoriesArray objectAtIndex:selectedCategoryIndex];
    
    NSNumberFormatter *decimalFormat = [[NSNumberFormatter alloc] init];
    [decimalFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    NSDecimalNumber *amount = [decimalFormat numberFromString:expenseTextField.text];
    
    if (amount <= 0) return;
    
    Comment *comment = [[Comment alloc] init];
    
    comment.text = [commentTextView text];
    
    Currency *currency = [[Currency alloc] init];
    currency.code = @"RUB";
    

    Transaction *transaction = [[Transaction alloc] init];
    
    transaction.added_on = [NSDate date];
    transaction.amount = amount;
    transaction.type = [NSNumber numberWithInt:1];
    transaction.category = category;
    transaction.comment = comment;
    transaction.currency = currency;
    

}

- (IBAction)saveCategory:(UIBarButtonItem *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    categoryViewContainer.frame = CGRectMake(0,415,320,255);
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.categoriesArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Category *category = [self.categoriesArray objectAtIndex:row];
    return category.name;
}

#pragma mark -
#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Category *category = [self.categoriesArray objectAtIndex:row];
    [categoryButton setTitle:category.name forState:UIControlStateNormal];
    
    self.selectedCategoryIndex = row;
}


#pragma mark -
#pragma mark TextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark -
#pragma mark TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
