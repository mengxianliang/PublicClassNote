

#import <AVFoundation/AVFoundation.h>
#import "THBaseCameraController.h"
#import "THCodeDetectionDelegate.h"

//cc_01
@interface THCameraController : THBaseCameraController

@property (weak, nonatomic) id <THCodeDetectionDelegate> codeDetectionDelegate;

@end
