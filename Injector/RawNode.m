//
//  RawNode.m
//  Injector
//
//  Created by Fabian Canas on 2/13/15.
//  Copyright (c) 2015 Fabián Cañas. All rights reserved.
//

#import "RawNode.h"
#import <OHMKitiOS/OHMKit.h>

@implementation RawNode

+ (void)load
{
    OHMMappable([RawNode class]);
    OHMAddArrayClasses([RawNode class], @{@"subnodes" : self});
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{{ type: %@, s : %@ }}", self.type, [self.subnodes description]];
}

@end
