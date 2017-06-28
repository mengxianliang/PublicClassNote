//
//  ViewController.m
//  Socket-服务端
//
//  Created by MengXianLiang on 2017/6/27.
//  Copyright © 2017年 JWZT. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <arpa/inet.h>
#import <netinet/in.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//
- (void)service {
    //错误代码 ===>
    int error;
    int fw = socket(AF_INET, SOCK_STREAM, 0);
    //返回正数代表成功
    BOOL success = (fw != -1);
    if (success) {
        //如果成功bind()方法进行绑定
        struct sockaddr_in addr;
        addr.sin_family = AF_INET;
        addr.sin_port = htons(1024);
        addr.sin_len = sizeof(addr);
        addr.sin_addr.s_addr = INADDR_ANY; //接收到的地址
        //返回值是int 判断是否绑定成功
        error = bind(fw, (const struct sockaddr *)&addr, sizeof(addr));
        success = (error == 0);
    }
    
    if (success) {
        NSLog(@"绑定了");
        //开始监听
        error = listen(fw, 5);
        success = (error == 0);
    }
    
    if (success) {
        NSLog(@"监听成功");
        while (true) {//死循环是为了保持长连接
            //接收客户端的数据 保持长连接 TCP
            struct sockaddr_in paddr;//接收客户端来的数据指针地址
            int peer;//判断是否成功
            socklen_t addrLen = sizeof(paddr);//返回一个长度
            peer = accept(fw, (struct sockaddr *)&paddr, &addrLen);//c语言去地址里取东西
            success = (peer != -1);
            if (success) {
                NSLog(@"接收成功");
                //做缓存处理
                char buffer[1024];
                ssize_t count;
                size_t len = sizeof(buffer);
                //我们一直在监听
                do {
                    count = recv(peer, buffer, len, 0);
                    NSString *str = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
                    NSLog(@"str = %@",str);
                } while (strcmp(buffer, "exit") != 0);//什么条件结束循环
            }
        }
    }
    //服务器的结束监听 需在客户端进行操作
    //关闭socket
    close(fw);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
