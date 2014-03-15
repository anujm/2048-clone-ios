//
//  ANJGameBoard.h
//  game
//
//  Created by anujmathur on 15/03/14.
//  Copyright (c) 2014 anujmathur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANJBlock.h"

@interface ANJGameBoard : NSObject
@property NSMutableArray* blocks;
@property int rows;
@property int columns;
@property(nonatomic) int score;

- (ANJGameBoard *) initBoard: (NSMutableArray *)blocks;

- (void)moveBlocksLeft;

- (void)moveBlocksRight;

- (void)moveBlocksUp;

- (void)moveBlocksDown;

- (int)emptyBlockCount;

- (void)addRandomBlock;
@end
