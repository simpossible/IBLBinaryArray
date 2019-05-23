//
//  IBIBinaryArray.h
//  IBIBinaryArray
//
//  Created by simp on 2019/5/23.
//  Copyright © 2019 simp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBIBinaryArrayProtocol <NSObject>

- (NSInteger)iblIndex;

@end

@interface IBIBinaryArray : NSObject

/**插入到对应的位置*/
- (void)insertObj:(id<IBIBinaryArrayProtocol>)obj;

- (id<IBIBinaryArrayProtocol>)objForIndex:(NSInteger)iblIndex;

@end

