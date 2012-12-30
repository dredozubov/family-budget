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
#import "CommentAPI.h"
#import "Currency.h"
#import "CurrencyAPI.h"
#import "Transaction.h"
#import "TransactionAPI.h"

@interface ExpenseViewController ()

@property (strong, nonatomic) DatabaseWriter *databaseWriter;
@property (strong, nonatomic) NSArray *categoriesArray;
@property (nonatomic) NSInteger selectedCategoryIndex;

@property (nonatomic, retain) NSManagedObjectContext *context;

@end

@implementation ExpenseViewController

@synthesize categoryViewContainer;
@synthesize categoryPicker;
@synthesize categoryButton;
@synthesize expenseTextField;
@synthesize commentTextView;

@synthesize context = _context;
@synthesize databaseWriter = _databaseWriter;
@synthesize categoriesArray = _categoriesArray;
@synthesize selectedCategoryIndex;

- (DatabaseWriter *) databaseWriter
{
    if (!_databaseWriter) {
        _databaseWriter = [[DatabaseWriter alloc] init];
        
        NSLog(@"ExpenseViewController: databaseWriter");
    }
    
    return _databaseWriter;
}

- (NSArray *) categoriesArray
{

    

    
    if (!_categoriesArray) {
        NSLog(@"Before: categoriesArray");
        _categoriesArray = [[self.databaseWriter category] findAll];
        NSLog(@"After: categoriesArray, %d", [_categoriesArray count]);
    }
        
    
    
    return _categoriesArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedCategoryIndex = -1;
    
    
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

- (id)initWithCoder:(NSCoder *)decoder
{
    if(self = [super initWithCoder:decoder]) {
        NSLog(@"init");
        [self databaseWriter];
    }
    
    return self;
    //if ([self databaseWriter]) { };
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
    
    
    NSNumberFormatter *decimalFormat = [[NSNumberFormatter alloc] init];
    [decimalFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *amount = [decimalFormat numberFromString:expenseTextField.text];
    
    //if (amount <= 0) return;
    
    

    Category *category = [self.categoriesArray objectAtIndex:selectedCategoryIndex];
    Comment *comment = [self.databaseWriter.comment findByText:@"restaraunt"];
    Currency *currency = [self.databaseWriter.currency findByCode:@"RUB"];
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                       currency, @"currency",
                                       category, @"category",
                                       comment, @"comment",
                                       [NSDate date], @"added_on",
                                       amount, @"amount",
                                       0, @"type",
                          nil];
    [self.databaseWriter.transaction insertWithDict:data];

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
