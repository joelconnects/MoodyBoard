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
        [[textField valueForKey:@"textInputTraits"] setValue:[UIColor blackColor] forKey:@"insertionPointColor"];
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self.email becomeFirstResponder];
    self.submit.userInteractionEnabled = NO;
    
}

- (void)textChanged:(UITextField *)textField
{
    NSLog(@"Text Changed");
    
    NSLog(@"textField did end editing");
    if ([self.email.text isEqualToString:self.emailConfirm.text]) {
        NSLog(@"did end - email equal email confirm");
        self.emailConfirm.userInteractionEnabled = NO;
        self.emailConfirm.attributedText = [[NSAttributedString alloc] initWithString:self.email.text attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    } else {
        
    }
    if ([self allFieldsValid])
    {
        self.submit.userInteractionEnabled = YES;
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


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.emailConfirm]) {
        NSLog(@"text field did begin editing - change color");
        self.emailConfirm.attributedText = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"text field did begin editing");
    
//    if ([textField isEqual:self.email]) {
//        if (
//            [textField.text isEqualToString:self.emailConfirm.text] &&
//            self.password.text.length == 0 &&
//            self.passwordConfirm.text.length == 0
//            )
//        {
//            self.emailConfirm.userInteractionEnabled = YES;
//            self.emailConfirm.text = @"";
//            [textField becomeFirstResponder];
//        }
//    }
    
    

    if ([textField isEqual:self.passwordConfirm]) {
        if (self.password.text.length == 0 &&
            [self validateEmail:self.email.text] &&
            [self validateEmail:self.emailConfirm.text]
            )
        {

            [self highlightBackgroundForValidationError:self.password placeholder:@"Enter password"];
            [self.password becomeFirstResponder];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
//    if ([self.password.text isEqualToString:@""] && [self.passwordConfirm.text isEqualToString:@""]) {
//        [self.password becomeFirstResponder];
//    }
    

    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"text field should end editing");
    BOOL valid = YES;
    
    // check email text for validity
    if ([textField isEqual:self.email]) {
        
//        valid = textField.text.length > 0;
//        if (!valid) {
//
//            [self highlightBackgroundForValidationError:textField placeholder:@"Enter email address"];
//            return valid;
//        }
        
        valid = [self validateEmail:textField.text];
        if (!valid) {
            
            NSLog(@"not valid email");
            textField.text = nil;
            [self highlightBackgroundForValidationError:textField placeholder:@"Enter valid email"];
            return valid;
        }
        return valid;
    }
    
    // check emailConfirm text for validity
    if ([textField isEqual:self.emailConfirm]) {
        
        valid = textField.text.length > 0;
        if (!valid) {
            
            if ([self validateEmail:self.email.text]) {return YES;}
            
            [self highlightBackgroundForValidationError:textField placeholder:@"Confirm email address"];
            return valid;
        }
        
        valid = [self.email.text isEqualToString:self.emailConfirm.text];
        if (!valid) {
            
            NSLog(@"emails do not match");
            textField.text = nil;
            [self highlightBackgroundForValidationError:textField placeholder:@"Email does not match"];
            
            return valid;
        }
        return valid;
    }
    
    // check password for validty
    if ([textField isEqual:self.password]) {
        
        valid = self.password.text.length > 0;
        if (!valid) {
//            [self highlightBackgroundForValidationError:textField placeholder:@"Enter password"];
            return YES;
        }
        
        
        valid = [self validatePassword:textField.text];
        if (!valid) {
            
            NSLog(@"not valid password");
            textField.text = nil;
            [self highlightBackgroundForValidationError:textField placeholder:@"Enter valid email"];
            return valid;
        }
        return valid;
    }
    
    return valid;
}

-(void)highlightBackgroundForValidationError:(UITextField *)textField placeholder:(NSString *)placehoderText {
    
    textField.backgroundColor = [UIColor clearColor];
    
    NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
    [attributesDictionary setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    [attributesDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [UIView animateKeyframesWithDuration:1.7 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            
            textField.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
            textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placehoderText attributes:attributesDictionary];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            
            textField.backgroundColor = [UIColor clearColor];
            
            
        }];
    } completion:^(BOOL finished) {
        textField.attributedPlaceholder = nil;
    }];
    
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

//-(void)showAlert {
//    
//    NSLog(@"show alert");
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
//                                                                   message:@""
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
//                                                            style:UIAlertActionStyleDefault
//                                                          handler:nil];
//    
//    [alert addAction:defaultAction];
//    alert.title = @"Uh oh!";
//    alert.message = @"Not a valid email address";
//    //    BOOL isAlert = [self isModal];
//    //    NSLog(isAlert ? @"Yes" : @"No");
//    [self presentViewController:alert animated:YES completion:^{
//        //        self.email.text = @"";
//    }];
//    
//}
//
//- (BOOL)isModal {
//    if([self presentingViewController])
//        return YES;
//    if([[self presentingViewController] presentedViewController] == self)
//        return YES;
//    
//    return NO;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}



@end
