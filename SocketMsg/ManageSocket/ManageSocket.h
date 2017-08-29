//
//  ManageSocket.h
//  Socket_msg
//
//  Created by kk on 2017/8/29.
//  Copyright © 2017年 fx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
@protocol TcpManagerDelegate <NSObject>

-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port;
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err;
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag;
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag;

@end

@interface ManageSocket : NSObject

@property(strong,nonatomic) GCDAsyncSocket *asyncsocket;
@property(nonatomic,strong)id<TcpManagerDelegate>delegate;

+ (instancetype)shareManageSocket;
-(BOOL)destroy;

@end
