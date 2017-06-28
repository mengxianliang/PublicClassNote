//
//  ViewController.m
//  Socket-客户端
//
//  Created by MengXianLiang on 2017/6/27.
//  Copyright © 2017年 JWZT. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
//阿帕奇
#import <arpa/inet.h>
@interface ViewController ()

@end

@implementation ViewController

//根据流程图做一个客户端，实现可以和服务端进行数据交互
//Socket --->iOS andriod c++之类的开发只要涉及到及时通讯，都是这个流程.
- (void)viewDidLoad {
    [super viewDidLoad];
    //一、创建客户端
    /**
     参数:
     1、int 传输协议  
     2、int 类型 SOCK_STREAM->TCP数据流  SOCK_DGRAM->UTP协议
     3、int 协议
     返回值 init 如果是正数代表创建成功
     */
    int client =  socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    //二、发起连接
    /**
     参数：
     1、int 客户端的Socket
     2、结构体 设置Socket信息
     3、连接长度
     */
    struct sockaddr_in serviceAddr;
    serviceAddr.sin_family = AF_INET;
    //4321 是一个端口号
    serviceAddr.sin_port = htons(4321);
    //强转成说需要的类型，直接将本机作为服务器来进行测试
    serviceAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    //返回值 int 如果返回一个正数代表创建失败，返回的正数代表错误码
    int result = connect(client, (const struct sockaddr*)&serviceAddr, sizeof(serviceAddr));
    if (result == 0) {
        
    } else {
        //代表失败
        NSLog(@"Socket连接失败，%d",result);
        return;
    }
    
    //代表成功 在服务器开启端口  让客户端进行连接
    //终端开启端口命令 ：nc -lk 4321
    NSLog(@"Socket连接成功");
    //接下来进行通讯
    NSString *message = @"Hello world !";
    //发送
    /**
     参数：
     1、socket 客户端
     2、指针 发送内容的一个地址
     3、发送内容的长度
     4、发送的标识 一般赋值为0
     message是一个什么类型的变量？OC
     */
    ssize_t sendLength = send(client, message.UTF8String, strlen(message.UTF8String), 0);
    NSLog(@"Socket发送了 %zd 个字符",sendLength);
    
    //服务器，给你回个消息
    /**
     参数
     1、客户端
     2、返回内容
     3、内容长度
     4、标识
     */
    //接收过来的数据 ---> 一般需要错缓存处理
    //接收的数据需要和发送的数据转化成一致
    //
    uint8_t buffer[1024];
    //接收数据的长度
    ssize_t recvLength = recv(client, buffer, sizeof(buffer), 0);
    NSLog(@"Socket到了 %zd 个字符",recvLength);
    //处理服务器返回的数据,可以看做是一个解析数据的过程
    NSData *data = [NSData dataWithBytes:buffer length:recvLength];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Socket收到数据：%@",str);
    
    //关闭socket
    close(client);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
