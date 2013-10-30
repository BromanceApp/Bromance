//
//  User.h
//  Bromance
//
//  Created by Justin Steffen on 10/28/13.
//  Copyright (c) 2013 Pamela Ocampo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *objectId;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSInteger age;
@property (strong, nonatomic) NSString *bio;


-(PFObject *) toPFObject;

#pragma mark Class Methods
+ (void)allUsersWithCompletion:(void (^)(NSArray *users, NSError *error))complete;
+ (User *)fromPFObject:(PFObject *)object;
@end
