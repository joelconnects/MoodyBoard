//
//  MDBSignUpController.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/7/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBSignUpViewController.h"
#import "Firebase.h"

@interface MDBSignUpViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *emailConfirm;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UIButton *submit;

@end

@implementation MDBSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UITextField *textField in self.view.subviews)
    {
        if ([textField isKindOfClass:[UITextField class]])
        {
            textField.delegate = self;
            [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        }
    }
    


}
-(void)viewDidAppear:(BOOL)animated {

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
 if confirm email is pressed before email is validated, 
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL valid = YES;
    
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
