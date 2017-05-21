//
//  FISViewController.m
//  validatedSignUp
//
//  Created by Joe Burgess on 7/2/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.userName.delegate = self;
    self.password.delegate = self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self displayConfirmationAlertFor:textField];
    
    if ([self validateText: textField]) {
        
        if (textField == self.password) {
            [self.view endEditing:YES];
            self.submitButton.enabled = YES;
        }
        
        UITextField *nextTF = [self nextTextFieldToEnable:textField];
        nextTF.enabled = YES;
        [nextTF becomeFirstResponder];
        return YES;
    }
    
    return NO;
}

-(BOOL) validateText:(UITextField *)textField
{
    
    BOOL isValidText = NO;
    
    if (textField == self.firstName) {
        
        isValidText = [self isValidName:textField.text];
        
    } else if (textField == self.lastName) {
        
        isValidText = [self isValidName:textField.text];
        
    } else if (textField == self.email) {
        
        isValidText = [self isValidEmail:textField.text];
        
    } else if (textField == self.userName){
        
        isValidText = [self isValidName:textField.text];
        
    } else if (textField == self.password) {
        
        isValidText = [self isValidPassword:textField.text];
    }
    
    return isValidText;
}

-(BOOL) isValidName: (NSString *) name
{
    return name.length > 0 && [name rangeOfCharacterFromSet:NSCharacterSet.decimalDigitCharacterSet].location == NSNotFound;
}

-(BOOL) isValidEmail: (NSString *) email
{
    return email.length > 0 && [email rangeOfString:@"@"].location != NSNotFound && [email rangeOfString:@"."].location != NSNotFound;
}

-(BOOL) isValidPassword: (NSString *) password
{
    return password.length > 6;
}

-(UITextField *) nextTextFieldToEnable : (UITextField *) currentTextField
{
    if (currentTextField == self.firstName) {
        
        return self.lastName;
        
    } else if (currentTextField == self.lastName) {
        
        return self.email;
        
    } else if (currentTextField == self.email) {
        
        return self.userName;
        
    } else if (currentTextField == self.userName) {
        
        return self.password;
    }
    
    return nil;
}

-(void) displayConfirmationAlertFor: (UITextField *)textField
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Are you Sure"
                                          message:@"select"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Clear", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       textField.text = @"";
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end




















