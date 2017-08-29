//
//  ManageSocket.m
//  Socket_msg
//
//  Created by kk on 2017/8/29.
//  Copyright © 2017年 fx. All rights reserved.
//

#import "ManageSocket.h"

@interface ManageSocket() <GCDAsyncSocketDelegate>

@end

@implementation ManageSocket

+ (instancetype)shareManageSocket {
    static ManageSocket *manageSocket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manageSocket = [[ManageSocket alloc] init];
        manageSocket.asyncsocket = [[GCDAsyncSocket alloc]initWithDelegate:manageSocket delegateQueue:dispatch_get_main_queue()];
    });
    return manageSocket;
}

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    if ([self.delegate respondsToSelector:@selector(socket:didConnectToHost:port:)]) {
        [self.delegate socket:sock didConnectToHost:host port:port];
    }
}

-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    if ([self.delegate respondsToSelector:@selector(socketDidDisconnect:withError:)]) {
        [self.delegate socketDidDisconnect:sock withError:err];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if ([self.delegate respondsToSelector:@selector(socket:didReadData:withTag:)]) {
        [self.delegate socket:sock didReadData:data withTag:tag];
    }
}

-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    if ([self.delegate respondsToSelector:@selector(socket:didWriteDataWithTag:)]) {
        [self.delegate socket:sock didWriteDataWithTag:tag];
    }
}

-(NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length {
    NSLog(@"timeout");
    return 0;
}

-(BOOL)destroy {
    [_asyncsocket disconnect];
    return YES;
}

@end
