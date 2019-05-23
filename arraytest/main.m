//
//  main.m
//  arraytest
//
//  Created by simp on 2019/5/23.
//  Copyright © 2019 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBIBinaryArray.h"

@interface IBLObj : NSObject<IBIBinaryArrayProtocol>

- (NSInteger)iblIndex;

@property (nonatomic, assign) NSInteger iblIndex;

@end

@implementation IBLObj

- (NSString *)description {
    return [NSString stringWithFormat:@"%@",@(self.iblIndex)];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        NSInteger number = 100000;
        IBIBinaryArray *array = [[IBIBinaryArray alloc] init];
        NSMutableDictionary *testDic = [NSMutableDictionary dictionary];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i < number; i ++) {
            IBLObj *obj = [[IBLObj alloc] init];
            obj.iblIndex = arc4random();
            [dataArray addObject:obj];
        }
        CFTimeInterval start = CFAbsoluteTimeGetCurrent();
        
        for (int i = 0; i < number; i ++) {
            IBLObj *obj = [dataArray objectAtIndex:i];
            [array insertObj:obj];
        }
        CFTimeInterval end = CFAbsoluteTimeGetCurrent();
        NSLog(@"the 二分数组花费的时间 ：%@",@(end-start));
        for (int i = 0; i < number; i ++) {
            IBLObj *obj = [dataArray objectAtIndex:i];
            [testDic setObject:obj forKey:@(obj.iblIndex)];
        }
         CFTimeInterval end1 = CFAbsoluteTimeGetCurrent();
        NSLog(@"the 原生字典数组花费的时间 ：%@",@(end1-end));
//        NSLog(@"原生字典是:%@",testDic);
//        NSLog(@"二分数组是:%@",array);
        
        NSInteger randomObj = arc4random() % number;
        IBLObj *obj = [dataArray objectAtIndex:randomObj];
         start = CFAbsoluteTimeGetCurrent();
        IBLObj *findObj = [array objForIndex:obj.iblIndex];
        NSLog(@"----%@",findObj);
        end = CFAbsoluteTimeGetCurrent();
        NSLog(@"the 二分数组查询花费的时间 ：%@",@(end-start));
         start = CFAbsoluteTimeGetCurrent();
         findObj = [testDic objectForKey:@(obj.iblIndex)];
        NSLog(@"----%@",findObj);
         end = CFAbsoluteTimeGetCurrent();
        NSLog(@"the 原生查询花费的时间 ：%@",@(end-start));
    }
    return 0;
}
