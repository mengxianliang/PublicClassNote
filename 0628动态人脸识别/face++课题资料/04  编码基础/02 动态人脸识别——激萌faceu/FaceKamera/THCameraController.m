
#import "THCameraController.h"
#import <AVFoundation/AVFoundation.h>

@interface THCameraController () // cc_02

//cc_03
@end

@implementation THCameraController

- (BOOL)setupSessionOutputs:(NSError **)error {

    //cc_04
    return NO;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {

    // cc_05

}

@end

