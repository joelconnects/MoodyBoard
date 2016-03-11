//
//  MDBImageRecord.h
//  MoodyBoard
//
//  Created by Joel Bell on 3/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageRecordState) {
    New,
    Downloaded,
    Failed
};

@interface MDBImageRecord : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) ImageRecordState state;

-(instancetype)initWithName:(NSString *)name url:(NSURL *)url;


@end

