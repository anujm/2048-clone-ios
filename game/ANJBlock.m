//
//  ANJBlock.m
//  game
//
//  Created by anujmathur on 15/03/14.
//  Copyright (c) 2014 anujmathur. All rights reserved.
//

#import "ANJBlock.h"

@implementation ANJBlock
- (ANJBlock *) initBlock:(int)x with:(int)y And:(int)value And:(BOOL)merged {
    self = [super init];
    self.x = x;
    self.y = y;
    self.value = value;
    self.merged = merged;
    return self;
}

@end
