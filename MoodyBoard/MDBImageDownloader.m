//
//  MDBImageDownloader.m
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBImageDownloader.h"

@implementation MDBImageDownloader

-(id)initWithImageRecord:(MDBImageRecord *)imageRecord {
    
    self = [super init];
    if (self) {
        _imageRecord = imageRecord;
    }
    
    return self;
}

-(void)main {
    
    if (self.cancelled) {
        return;
    }
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:self.imageRecord.url];
    
    if (self.cancelled) {
        return;
    }
    
    if (data.length > 0) {
        self.imageRecord.image = [UIImage imageWithData:data];
        self.imageRecord.state = Downloaded;
    } else {
        self.imageRecord.state = Failed;
        self.imageRecord.image = [UIImage imageNamed:@"failed"];
    }
    
}

@end



