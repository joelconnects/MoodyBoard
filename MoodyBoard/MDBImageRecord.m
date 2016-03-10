//
//  MDBImageRecord.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBImageRecord.h"

@implementation MDBImageRecord


-(id)initWithName:(NSString *)name url:(NSURL *)url {
    
    self = [super init];
    
    if (self) {
        _name = name;
        _url = url;
        _state = New;
        _image = [UIImage imageNamed:@"placeholder"];
    }
    
    return self;
    
}


@end