
#import "THPreviewView.h"

@interface THPreviewView ()

    //cc_06
@end

@implementation THPreviewView

+ (Class)layerClass {

    //cc_07

    return nil;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {

    //cc_08

}

- (AVCaptureSession*)session {

    //cc_09
    return nil;
}

- (void)setSession:(AVCaptureSession *)session {

    //cc_10
}

- (AVCaptureVideoPreviewLayer *)previewLayer {

    //cc_11
    return nil;
}

- (void)didDetectFaces:(NSArray *)faces {

    //cc_12

}

- (NSArray *)transformedFacesFromFaces:(NSArray *)faces {

    //cc_13

    return nil;
}

- (CALayer *)makeFaceLayer {

    //cc_14
    return nil;
}



- (CATransform3D)transformForRollAngle:(CGFloat)rollAngleInDegrees {

    //cc_15

    return CATransform3DIdentity;
}

- (CATransform3D)transformForYawAngle:(CGFloat)yawAngleInDegrees {

    //cc_16

    return CATransform3DIdentity;
}

- (CATransform3D)orientationTransform {

    //cc_17
    return CATransform3DIdentity;
}

// The clang pragmas can be removed when you're finished with the project.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused"

static CGFloat THDegreesToRadians(CGFloat degrees) {

    //cc_18
    return 0.0f;
}

static CATransform3D CATransform3DMakePerspective(CGFloat eyePosition) {

    //cc_19

    return CATransform3DIdentity;

}
#pragma clang diagnostic pop

@end
