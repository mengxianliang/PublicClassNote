
#import <AVFoundation/AVFoundation.h>
#import "THCodeDetectionDelegate.h"

@interface THPreviewView : UIView <THCodeDetectionDelegate>

@property (strong, nonatomic) AVCaptureSession *session;

@end
