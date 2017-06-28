
#import "THCameraController.h"
#import <AVFoundation/AVFoundation.h>

//cc_02

@implementation THCameraController

- (NSString *)sessionPreset {

    //cc_03

    return nil;
}

- (BOOL)setupSessionInputs:(NSError *__autoreleasing *)error {

    //cc_04

    return NO;
}

- (BOOL)setupSessionOutputs:(NSError **)error {

    //cc_05
    return NO;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {

    //cc_06

}



@end

