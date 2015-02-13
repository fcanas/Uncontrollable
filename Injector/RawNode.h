//
//  RawNode.h
//  Injector
//
//  Created by Fabian Canas on 2/13/15.
//  Copyright (c) 2015 Fabián Cañas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RawNode : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSDictionary *properties;
@property (nonatomic, strong) NSArray *subnodes;
@end
