
//
//  ANJGameBoard.m
//  game
//
//  Created by anujmathur on 15/03/14.
//  Copyright (c) 2014 anujmathur. All rights reserved.
//
#import "ANJGameBoard.h"
#import "NSArray+ObjectiveSugar.h"

@interface ANJGameBoard ()
- (NSArray *)generateNRand:(int)n inMax:(int)max;

- (ANJBlock *)nextFilledBlockRight:(int)index1 And:(int)and;
@end

@implementation ANJGameBoard

int ROW_COUNT = 4;
int COLUMN_COUNT = 4;
int FILLED_BLOCKS_AT_START = 2;


- (ANJGameBoard *)init {
    NSMutableArray *blocks = [[NSMutableArray alloc] initWithCapacity:ROW_COUNT];
    for (int i = 0; i < ROW_COUNT; i++) {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:COLUMN_COUNT];
        for (int j = 0; j < COLUMN_COUNT; j++) {
            row[j] = [[ANJBlock alloc] initBlock:j with:i And:0 And:FALSE];
        }
        blocks[i] = row;
    }
    [self fillRandomBlocks:blocks];
    return [[ANJGameBoard alloc] initBoard:blocks];
}

- (void)fillRandomBlocks:(NSMutableArray *)blocks {
    NSMutableArray *randomNumbers =
            [[self generateNRand:FILLED_BLOCKS_AT_START inMax:ROW_COUNT * COLUMN_COUNT - 1] mutableCopy];

    for(int i = 0; i < FILLED_BLOCKS_AT_START; i++) {
        int randomx = [randomNumbers[i] intValue] / COLUMN_COUNT;
        int randomy = ([randomNumbers[i] intValue] % COLUMN_COUNT);
        ((ANJBlock *)blocks[randomx][randomy]).value = 2;
    }
}


- (ANJGameBoard *)initBoard:(NSMutableArray *)blocks {
    self = [super init];
    self.blocks = blocks;
    self.rows = ROW_COUNT;
    self.columns = COLUMN_COUNT;
    return self;
}

- (NSArray *)generateNRand:(int)n inMax:(int)max {
    NSMutableArray * numbers = [[NSMutableArray alloc] initWithCapacity:max];
    for (int k = 0; k < n; ++k)
        numbers[k] = [NSNumber numberWithInt:k];
    for(int k = n ; k < max; ++k) {
        int v = arc4random() % (k+1);
        if(v < n) {
            numbers[v] = [NSNumber numberWithInt:k];
        }
    }
    return numbers;
}

- (ANJBlock *)nextFilledBlockRight:(int)row And:(int)index {
    for(int col = index + 1; col < COLUMN_COUNT; col++) {
        ANJBlock *block = self.blocks[row][col];
        if (block.value != 0) return block;
    }
    return NULL;
}

- (void)moveBlocksLeft {
    for (int passes = 0; passes < 2; passes++) {
        for(int i = 0; i < ROW_COUNT; i++) {
            for(int j = 0; j < COLUMN_COUNT - 1; j++) {
                ANJBlock *filledBlock = [self nextFilledBlockRight:i And:j];
                if (filledBlock == NULL) continue;
                [self moveBlockAndMerge:i j:j filledBlock:filledBlock];
            }
        }
    }
}

- (void)moveBlockAndMerge:(int)i j:(int)j filledBlock:(ANJBlock *)filledBlock {
    ANJBlock *currentBlock = self.blocks[i][j];
    if (currentBlock.value == 0) {
        currentBlock.value = filledBlock.value;
        filledBlock.value = 0;
    }
    else if(currentBlock.value == filledBlock.value) {
        currentBlock.value += filledBlock.value;
        filledBlock.value = 0;
        currentBlock.merged = TRUE;
        self.score += 10 + currentBlock.value;
    }
}

- (ANJBlock *)nextFilledBlockLeft:(int)row And:(int)index {
    for(int col = index - 1; col >= 0; col--) {
        ANJBlock *block = self.blocks[row][col];
        if (block.value != 0) return block;
    }
    return NULL;
}

- (void)moveBlocksRight {
    for (int passes = 0; passes < 2; passes++) {
        for(int i = 0; i < ROW_COUNT; i++) {
            for(int j = COLUMN_COUNT - 1; j > 0; j--) {
                ANJBlock *filledBlock = [self nextFilledBlockLeft:i And:j];
                if (filledBlock == NULL) continue;
                [self moveBlockAndMerge:i j:j filledBlock:filledBlock];
            }
        }
    }
}

- (ANJBlock *)nextFilledBlockDown:(int)index And:(int)col {
    for(int row = index - 1; row >= 0; row--) {
        ANJBlock *block = self.blocks[row][col];
        if (block.value != 0) return block;
    }
    return NULL;
}

- (void)moveBlocksUp {
    for (int passes = 0; passes < 2; passes++) {
        for(int i = ROW_COUNT - 1; i > 0; i--) {
            for(int j = 0; j < COLUMN_COUNT; j++) {
                ANJBlock *filledBlock = [self nextFilledBlockDown:i And:j];
                if (filledBlock == NULL) continue;
                [self moveBlockAndMerge:i j:j filledBlock:filledBlock];
            }
        }
    }
}

- (ANJBlock *)nextFilledBlockUp:(int)index And:(int)col {
    for(int row = index + 1; row < ROW_COUNT; row++) {
        ANJBlock *block = self.blocks[row][col];
        if (block.value != 0) return block;
    }
    return NULL;
}

- (void)moveBlocksDown {
    for (int passes = 0; passes < 2; passes++) {
        for(int i = 0; i < ROW_COUNT - 1 ; i++) {
            for(int j = 0; j < COLUMN_COUNT; j++) {
                ANJBlock *filledBlock = [self nextFilledBlockUp:i And:j];
                if (filledBlock == NULL) continue;
                [self moveBlockAndMerge:i j:j filledBlock:filledBlock];
            }
        }
    }
}

- (int)emptyBlockCount {
    int count = 0;
    for(int i= 0; i < ROW_COUNT; i++) {
        for(int j = 0; j < COLUMN_COUNT; j++) {
            ANJBlock *currentBlock = self.blocks[i][j];
            if (currentBlock.value == 0) count += 1;
        }
    }
    return count;
}

- (void)addRandomBlock {
    NSMutableArray *emptyBlockIndexes = [@[] mutableCopy];
    for(int i = 0; i < ROW_COUNT; i++) {
        for(int j = 0; j < COLUMN_COUNT; j++) {
            ANJBlock *currentBlock = self.blocks[i][j];
            if(currentBlock.value == 0) {
                [emptyBlockIndexes addObject:[NSNumber numberWithInt:(i * ROW_COUNT + j)]];
            }
        }
    }
    NSNumber *randomEmptyBlockIndex = [emptyBlockIndexes objectAtIndex:arc4random() % emptyBlockIndexes.count];
    ANJBlock *blockAtRandomIndex = self.blocks[[randomEmptyBlockIndex intValue] / ROW_COUNT][[randomEmptyBlockIndex intValue] % COLUMN_COUNT];
    blockAtRandomIndex.value = 2;
}

@end
