//
//  AddPersonViewController.h
//  HBCoredata
//
//  Created by SourceKode on 20/12/14.
//  Copyright (c) 2014 iHrishikesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPersonViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *age;

- (IBAction)addPersonClicked:(UIButton *)sender;

@end
