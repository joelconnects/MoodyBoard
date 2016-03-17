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
    }
    
    self.email.layer.cornerRadius=10.0f;
    self.email.layer.masksToBounds=YES;
    self.email.layer.borderColor=[[UIColor colorWithRed:220/255.0 green:20/255.0 blue:60/255.0 alpha:0.3]CGColor];
    self.email.layer.borderWidth= 5.0f;
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self.email becomeFirstResponder];
    
}

- (void)textChanged:(UITextField *)textField
{
    NSLog(@"Text Changed");
    if ([self allFieldsValid])
    {
        self.submit.userInteractionEnabled = YES;
    }
}

- (BOOL)allFieldsValid
{
    NSLog(@"all field valid method");
    for (UITextField *textField in self.textFields) {
        textField.alpha = 1;
        textField.backgroundColor = [UIColor clearColor];
    }
    if (
        [self validateEmail:self.email.text] &&
        [self validateEmail:self.emailConfirm.text] &&
        [self validatePassword:self.password.text] &&
        [self validatePassword:self.passwordConfirm.text]
        )
    {
        return YES;
    }
    return NO;
}
/*
 email is first responder
 if confirm email (or not email) is pressed before email is validated,
    highlight email
 */

-(void)showAlert {
    
    NSLog(@"show alert");
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    [alert addAction:defaultAction];
    alert.title = @"Uh oh!";
    alert.message = @"Not a valid email address";
//    BOOL isAlert = [self isModal];
//    NSLog(isAlert ? @"Yes" : @"No");
    [self presentViewController:alert animated:YES completion:^{
//        self.email.text = @"";
    }];
    
}

- (BOOL)isModal {
    if([self presentingViewController])
        return YES;
    if([[self presentingViewController] presentedViewController] == self)
        return YES;
    
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textField did end editing");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"text field should end editing");
    BOOL valid = YES;
    
    if ([textField isEqual:self.email]) {
        
        valid = textField.text.length > 0;
        if (!valid) {
//            self.email.alpha = 0;
            self.email.backgroundColor = [UIColor clearColor];
            NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
            [attributesDictionary setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
            [attributesDictionary setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
            [UIView animateKeyframesWithDuration:2.0 delay:0 options:0 animations:^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
                    self.email.backgroundColor = [UIColor colorWithRed:220/255.0 green:20/255.0 blue:60/255.0 alpha:0.5];
                    self.email.attributedText = [[NSAttributedString alloc] initWithString:@"Not a valid email address" attributes:attributesDictionary];
                }];
                [UIView addKeyframeWithRelativeStartTime:1.0 relativeDuration:1.0 animations:^{
                    NSLog(@"fade red");
                    self.email.backgroundColor = [UIColor colorWithRed:220/255.0 green:20/255.0 blue:60/255.0 alpha:0.1];
                    
                }];
            } completion:^(BOOL finished) {
                self.email.alpha = 1;
                

                
                
            }];
            
//            [UIView animateWithDuration:0.75 animations:^{
//                self.email.alpha = 0.2;
//                self.email.backgroundColor = [UIColor redColor];
//            }];
            return valid;        }
        
        valid = [self validateEmail:textField.text];
        if (!valid) {
            
            
            [self showAlert];
            return YES;


        }
        return valid;
    }
    
    
    if (textField.text.length == 0)
    {
        return valid;
    }
    
    if ([textField isEqual:self.email]) {
        //
    }
    
    if ([textField isEqual:self.email] || [textField isEqual:self.emailConfirm])
    {
        valid = [self validateEmail:textField.text];
        if (!valid)
        {
//            [self alertWithInvalidField:@"Email"];
        }
    }
    else if ([textField isEqual:self.password] || [textField isEqual:self.passwordConfirm])
    {
        valid = [self validatePassword:textField.text];
        if (!valid)
        {
//            [self alertWithInvalidField:@"Password"];
        }
    }
    
    return valid;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
