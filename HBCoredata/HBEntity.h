//
//  HBEntity.h
//  HBCoredata
//
//  Created by SourceKode on 14/12/14.
//  Copyright (c) 2014 iHrishikesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HBEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end
