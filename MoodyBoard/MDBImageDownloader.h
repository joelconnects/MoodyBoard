//
//  MDBImageDownloader.h
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDBImageRecord.h"

@interface MDBImageDownloader : NSOperation

@property (strong, nonatomic) MDBImageRecord *imageRecord;

@end


 
