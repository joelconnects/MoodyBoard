//
//  MDBBoardLayoutMultipliers.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/8/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardLayoutMultipliers.h"

@implementation MDBBoardLayoutMultipliers

+(NSDictionary*)offsetMultipliers {
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @{
                 @0 : @[@0.628019323671498000, @0.502717391304348000],
                 @1 : @[@0.490338164251208000, @0.005434782608695650],
                 @2 : @[@0.210144927536232000, @0.252717391304348000],
                 @3 : @[@0.019323671497584500, @0.528532608695652000],
                 @4 : @[@0.251207729468599000, @0.436141304347826000],
                 @5 : @[@0.666666666666667000, @0.426630434782609000],
                 @6 : @[@0.000000000000000000, @0.426630434782609000],
                 @7 : @[@0.666666666666667000, @0.421195652173913000],
                 @8 : @[@0.009661835748792270, @0.614130434782609000],
                 @9 : @[@0.589371980676328000, @0.758152173913043000],
                 @10 : @[@0.000000000000000000, @0.758152173913043000],
                 @11 : @[@0.589371980676328000, @0.758152173913043000],
                 @12 : @[@0.371980676328502000, @0.763586956521739000],
                 @13 : @[@0.000000000000000000, @0.855978260869565000]
                 };
    });
    return inst;
}

+(NSDictionary*)sizeMultipliers {
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @{
                 @"XL" : @[@0.509661835748792, @0.286684782608696],
                 @"L" : @[@0.458937198067633, @0.258152173913043],
                 @"M" : @[@0.410628019323671, @0.230978260869565],
                 @"S" : @[@0.314009661835749, @0.176630434782609],
                 @"XS" : @[@0.256038647342995, @0.144021739130435]
                 };
    });
    return inst;
}


@end
