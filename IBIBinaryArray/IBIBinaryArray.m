//
//  IBIBinaryArray.m
//  IBIBinaryArray
//
//  Created by simp on 2019/5/23.
//  Copyright © 2019 simp. All rights reserved.
//

#import "IBIBinaryArray.h"

@interface IBIBinaryArray()

@property (nonatomic, strong) NSMutableArray * array;

@end

@implementation IBIBinaryArray

- (instancetype)init {
    if (self = [super init]) {
        self.array = [NSMutableArray arrayWithCapacity:1000000];
    }
    return self;
}

/**插入到对应的位置*/
- (void)insertObj:(id<IBIBinaryArrayProtocol>)obj {
    if (self.array.count == 0) {
        [self.array addObject:obj];
    }
    if (obj) {
        [self insertObj:obj from:0 end:self.array.count-1];
    }
}

- (void)insertObj:(id<IBIBinaryArrayProtocol>)obj from:(NSInteger)start end:(NSInteger)end {
    NSInteger insertIndex = obj.iblIndex;
    if (start == end) {
        id<IBIBinaryArrayProtocol> startObj = [self.array objectAtIndex:start];
        if (insertIndex <= startObj.iblIndex) {
            [self.array insertObject:obj atIndex:start];
        }else {
            [self.array insertObject:obj atIndex:start +1];
        }
    }else {
        id<IBIBinaryArrayProtocol> startObj = [self.array objectAtIndex:start];
        id<IBIBinaryArrayProtocol> endObj = [self.array objectAtIndex:end];
        if (startObj.iblIndex >= insertIndex) {
            [self.array insertObject:obj atIndex:start];
            return;
        }
        
        if (endObj.iblIndex <= insertIndex) {
            [self.array insertObject:obj atIndex:end+1];
            return;
        }
        
        if (end - start == 1) {//只是相差一个
            [self.array insertObject:obj atIndex:end];
            return;
        }else {
            NSInteger center = (start + end)/2;
            id<IBIBinaryArrayProtocol> centerObj = [self.array objectAtIndex:center];
            if (centerObj.iblIndex == insertIndex) {
                [self.array insertObject:obj atIndex:center];
                return;
            }
            if (centerObj.iblIndex > insertIndex) {
                [self insertObj:obj from:start end:center];
                return;
            }else {
                [self insertObj:obj from:center end:end];
                return;
            }
        }
        
    }
}

- (id<IBIBinaryArrayProtocol>)objForIndex:(NSInteger)iblIndex {
    if (self.array.count == 0) {
        return nil;
    }
    return [self objForIndex:iblIndex from:0 end:self.array.count -1];
}

- (id<IBIBinaryArrayProtocol>)objForIndex:(NSInteger)iblIndex from:(NSInteger)start end:(NSInteger)end {
    if (start == end) {
        id<IBIBinaryArrayProtocol> startObj = [self.array objectAtIndex:start];
        if (startObj.iblIndex == iblIndex) {
            return startObj;
        }
    }else {
        id<IBIBinaryArrayProtocol> startObj = [self.array objectAtIndex:start];
        id<IBIBinaryArrayProtocol> endObj = [self.array objectAtIndex:end];
        if (startObj.iblIndex == iblIndex) {
            return startObj;
        }
        
        if (endObj.iblIndex == iblIndex) {
            return endObj;
        }
        
        if (end - start == 1) {//只是相差一个
            return nil;
        }else {
            NSInteger center = (start + end)/2;
            id<IBIBinaryArrayProtocol> centerObj = [self.array objectAtIndex:center];
            if (centerObj.iblIndex == iblIndex) {
                return centerObj;
            }
            if (centerObj.iblIndex > iblIndex) {
                return [self objForIndex:iblIndex from:start end:center];
            }else {
                return [self objForIndex:iblIndex from:center end:end];
            }
        }
    }
    return nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",self.array];
}

@end
