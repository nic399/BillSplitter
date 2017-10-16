//
//  ViewController.m
//  BillSplitter
//
//  Created by Nicholas Fung on 2017-10-15.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTotalTextField;
@property (weak, nonatomic) IBOutlet UISlider *totalPersonsSlider;
@property (weak, nonatomic) IBOutlet UILabel *billPerPersonLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)splitBillAction:(id)sender {
    if (![self.billTotalTextField.text doubleValue]) {
        return;
    }
    NSNumberFormatter *moneyFormetter = [[NSNumberFormatter alloc] init];
    [moneyFormetter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSDecimalNumber *billAmount = [[NSDecimalNumber alloc] initWithString: self.billTotalTextField.text];
    NSDecimalNumber *totalPeople = [[NSDecimalNumber alloc] initWithFloat:self.totalPersonsSlider.value];
    NSDecimalNumber *amountPerPerson = [billAmount decimalNumberByDividingBy:totalPeople];
    self.billPerPersonLabel.text = [NSString stringWithFormat:@"Each of the %d people pay %@", (int)self.totalPersonsSlider.value, [moneyFormetter stringFromNumber:amountPerPerson]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self splitBillAction:self];
}


- (IBAction)totalPersonsSliderValueChanged:(UISlider *)sender {
    [sender setValue: roundf(sender.value)];
    NSLog(@"Slider value is %f", sender.value);
    [self splitBillAction:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *decimalNumberCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
    NSRange testForNonNumbers = [string rangeOfCharacterFromSet:[decimalNumberCharacterSet invertedSet]];
    if (testForNonNumbers.length == 0) {
        if ([textField.text containsString:@"."] && [string containsString:@"."]) { //text field already has a decimal point
            return false;
        }
    }
    else {
        return false;
    }
    [self splitBillAction:self];
    return true;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
