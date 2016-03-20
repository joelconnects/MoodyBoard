//
//  MDBSignUpController.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBSignUpViewController.h"
#import "Firebase.h"
#import "MDBConstants.h"

@interface MDBSignUpViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *emailConfirm;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) NSArray *textFields;
@property (strong, nonatomic) NSNumber *index;

@end

@implementation MDBSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view did load");
    
    self.textFields = @[self.email,self.emailConfirm,self.password,self.passwordConfirm];
    
    for (UITextField *textField in self.textFields)
    {
        NSLog(@"if textfield in subviews");
        textField.delegate = self;
        [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        [[textField valueForKey:@"textInputTraits"] setValue:[[UIColor blackColor] colorWithAlphaComponent:0.3] forKey:@"insertionPointColor"];
    }
    
    self.password.secureTextEntry = YES;
    self.passwordConfirm.secureTextEntry = YES;
    self.submit.userInteractionEnabled = NO;
    
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self.email becomeFirstResponder];

}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"text field did begin editing");
    
    if ([textField isEqual:self.email]) {
        self.index = [NSNumber numberWithInteger:0];
        return;
    }
    if ([textField isEqual:self.password]) {
        self.index = [NSNumber numberWithInteger:2];
    }
    
    
}

- (void)textChanged:(UITextField *)textField
{
    NSLog(@"Text Changed");
    
    if ([self allFieldsValid])
    {
        self.submit.userInteractionEnabled = YES;
    } else {
        self.submit.userInteractionEnabled = NO;
    }
    
    NSInteger arrayIndex = [self.textFields indexOfObject:textField];
    
    if ([self.index integerValue] == 0) {
        if (self.emailConfirm.text.length > 0 || self.password.text.length > 0) {
            self.emailConfirm.text = nil;
            self.password.text = nil;
            self.passwordConfirm.text = nil;
            self.emailConfirm.userInteractionEnabled = YES;
            self.passwordConfirm.userInteractionEnabled = YES;
        }
        
    }
    
    if ([self.index integerValue] == 1) {
        if (arrayIndex > [self.index integerValue]) {
            NSLog(@"array tom foolery");
            [textField resignFirstResponder];
            [self.emailConfirm becomeFirstResponder];
            [self highlightBackgroundToPromptUser:self.emailConfirm];
        }
        
        UIColor *color = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1.0];
        
        if ([self.email.text isEqualToString:self.emailConfirm.text]) {
            
            self.emailConfirm.attributedText = [[NSAttributedString alloc] initWithString:self.email.text attributes:@{NSForegroundColorAttributeName: color}];
            [self.emailConfirm resignFirstResponder];
            [self.password becomeFirstResponder];
            [self highlightBackgroundToPromptUser:self.password];
            self.emailConfirm.userInteractionEnabled = NO;
            
        } else {
            
            self.emailConfirm.attributedText = [[NSAttributedString alloc] initWithString:self.emailConfirm.text attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        }
        return;
        
    }
    
    if ([self.index integerValue] == 2) {
        
        if (![self validateEmail:self.emailConfirm.text]) {
            NSLog(@"2, length, validate");
            self.emailConfirm.text = nil;
            [textField resignFirstResponder];
            [self.emailConfirm becomeFirstResponder];
            [self highlightBackgroundToPromptUser:self.emailConfirm];
            return;
        }
        if (arrayIndex > [self.index integerValue]) {
            NSLog(@"array tom foolery");
            [textField resignFirstResponder];
            [self.password becomeFirstResponder];
            [self highlightBackgroundToPromptUser:self.password];
        }
        if (self.passwordConfirm.text.length > 0 || self.email.text.length > 0) {
            
            self.passwordConfirm.text = nil;
            
        }

        self.passwordConfirm.userInteractionEnabled = YES;
        
    }
    
    if ([self.index integerValue] == 3) {
        if (![self validatePassword:self.password.text]) {
            [textField resignFirstResponder];
            [self.password becomeFirstResponder];
            [self highlightBackgroundToPromptUser:self.password];
        }
        
        UIColor *color = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1.0];
        
        if ([self.password.text isEqualToString:self.passwordConfirm.text]) {
            
            self.passwordConfirm.attributedText = [[NSAttributedString alloc] initWithString:self.password.text attributes:@{NSForegroundColorAttributeName: color}];
            [self.passwordConfirm resignFirstResponder];
            [self.submit becomeFirstResponder];
            self.passwordConfirm.userInteractionEnabled = NO;
            
        } else {
            
            
            self.passwordConfirm.attributedText = [[NSAttributedString alloc] initWithString:self.passwordConfirm.text attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        }
        
        return;
    }
    
}

- (BOOL)allFieldsValid
{
    NSLog(@"all field valid method");
    if (
        [self.email.text isEqualToString:self.emailConfirm.text] &&
        [self.password.text isEqualToString:self.passwordConfirm.text]
        )
    {
        return YES;
    }
    return NO;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"text field should end editing");
    BOOL valid = YES;
    
    // check email text for validity
    if ([textField isEqual:self.email]) {
        
        valid = [self validateEmail:textField.text];
        if (!valid) {
            
            NSLog(@"email not valid");
            if (self.email.text.length == 0) {
                [self highlightBackgroundToPromptUser:textField];
            } else {
                textField.text = nil;
                [self highlightBackgroundForValidationError:textField placeholder:@"Enter valid email"];
            }
            
        }
        self.index = [NSNumber numberWithInteger:1];
        return valid;
    }
    
    // check emailConfirm text for validity
    if ([textField isEqual:self.emailConfirm]) {
        
        valid = [self.email.text isEqualToString:self.emailConfirm.text];
        if (!valid) {
            
            NSLog(@"emails do not match");
            textField.text = nil;
            if ([self.index integerValue] > 0) {
                [self highlightBackgroundForValidationError:textField placeholder:@"Email does not match"];
            }
        } else {
            self.index = [NSNumber numberWithInteger:2];
        }
        return YES;
    }
    
    // check password for validty
    if ([textField isEqual:self.password]) {
        
        if (![self validatePassword:textField.text]) {
            NSLog(@"not valid password");
            textField.text = nil;
            if ([self.index integerValue] > 1 && [self validateEmail:self.emailConfirm.text]) {
                [self highlightBackgroundForValidationError:textField placeholder:@"Enter valid password"];
            }
        } else {
            self.index = [NSNumber numberWithInteger:3];
        }
        return YES;
    }
    
    // check password for validty
    if ([textField isEqual:self.passwordConfirm]) {
        
        valid = [self.password.text isEqualToString:self.passwordConfirm.text];
        if (!valid) {
            
            NSLog(@"passwords do not match");
            textField.text = nil;
            if ([self.index integerValue] > 2) {
                [self highlightBackgroundForValidationError:textField placeholder:@"Password does not match"];
            }
        }
        return YES;
    }
    
    return valid;
}

-(void)highlightBackgroundForValidationError:(UITextField *)textField placeholder:(NSString *)placeholderText {
    
    textField.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
    [attributesDictionary setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    [attributesDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [UIView animateKeyframesWithDuration:1.7 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            
            
            textField.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:attributesDictionary];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            
            textField.backgroundColor = [UIColor clearColor];
            
            
            
        }];
    } completion:^(BOOL finished) {
        
        NSString *placeholderTextPostAnimation = @"";
        
        if ([textField isEqual:self.email]) {
            placeholderTextPostAnimation = @"Email";
        }
        if ([textField isEqual:self.emailConfirm]) {
            placeholderTextPostAnimation = @"Confirm email";
        
        }
        if ([textField isEqual:self.password]) {
            placeholderTextPostAnimation = @"Password";
            
        }
        if ([textField isEqual:self.passwordConfirm]) {
            placeholderTextPostAnimation = @"Confirm password";
            
        }
        UIColor *color = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1.0];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderTextPostAnimation attributes:@{NSForegroundColorAttributeName: color }];
        
    }];
    
}

-(void)highlightBackgroundToPromptUser:(UITextField *)textField {
    
    [UIView animateKeyframesWithDuration:0.7 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
            
            textField.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            
            textField.backgroundColor = [UIColor clearColor];

        }];
    } completion:nil];
    
}

- (BOOL)validateEmail:(NSString *)email
{
    if ([email length] < 3){ return NO;}
    if ([email rangeOfString:@"@"].location == NSNotFound){return NO;}
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:email options:0 range:NSMakeRange(0, [email length])];
    
    if (regExMatches == 0)
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)validatePassword:(NSString *)password
{
    NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    if ( [password length]<6 || [password length]>20 )
        return NO;  // too long or too short
    NSRange rang;
    rang = [password rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
    rang = [password rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )
        return NO;  // no number;
    rang = [password rangeOfCharacterFromSet:upperCaseChars];
    if ( !rang.length )
        return NO;  // no uppercase letter;
    rang = [password rangeOfCharacterFromSet:lowerCaseChars];
    if ( !rang.length )
        return NO;  // no lowerCase Chars;
    return YES;
}



- (IBAction)loginUser:(id)sender {
    
    Firebase *ref = [[Firebase alloc] initWithUrl:@"https://moodyboard.firebaseio.com"];
    [ref createUser:@"bobtony@example.com" password:@"correcthorsebatterystaple" withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        
        if (error) {
            // There was an error creating the account
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
            ;
        }
    
    }];
}




@end
