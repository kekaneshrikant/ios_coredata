//
//  AddPersonViewController.m
//  HBCoredata
//
//  Created by SourceKode on 20/12/14.
//  Copyright (c) 2014 iHrishikesh. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AppDelegate.h"
#import "HBEntity.h"

@interface AddPersonViewController ()

@end

@implementation AddPersonViewController

-(NSManagedObjectContext *) managedObjectContext{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL) createNewPersonFirstName:(NSString *)fname AndLastName:(NSString *)lName AndAge:(NSNumber *)age{
    BOOL result=NO;
    if([fname length] ==0 || [lName length]==0){
        NSLog(@"values are empty");
        return NO;
    }
    HBEntity *newPerson=[NSEntityDescription insertNewObjectForEntityForName:@"HBEntity" inManagedObjectContext:self.managedObjectContext];
    
    newPerson.firstName=fname;
    newPerson.lastName=lName;
    newPerson.age=age;
    
    NSError *err=nil;
    if([self.managedObjectContext save:&err]){
        return YES;
    }
    else{
        NSLog(@"fail err: %@",err);
    }
    return result;
}


- (IBAction)addPersonClicked:(UIButton *)sender {
    
    NSLog(@"%@ %@ %@",self.firstNameTextField.text,self.lastNameTextField.text,self.age.text);
    
     NSNumber *numberedAge = [NSNumber numberWithInt:(int)self.age.text.integerValue];
    
    [self createNewPersonFirstName:self.firstNameTextField.text AndLastName:self.lastNameTextField.text AndAge:numberedAge];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
