//
//  ANJBlock.h
//  game
//
//  Created by anujmathur on 15/03/14.
//  Copyright (c) 2014 anujmathur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANJBlock : NSObject
@property int x;
@property int y;
@property int value;
@property BOOL merged;

-(ANJBlock *) initBlock: (int) x with: (int) y And: (int)value And: (BOOL)merged;
@end
