
#import "THPreviewView.h"

@interface THPreviewView ()

//cc_07

@end

@implementation THPreviewView

+ (Class)layerClass {

    //cc_08

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

    //cc_09

}

- (AVCaptureSession*)session {

    //cc_10
    return nil;
}

- (void)setSession:(AVCaptureSession *)session {

    //cc_11

}

- (AVCaptureVideoPreviewLayer *)previewLayer {

    //cc_12

    return nil;
}

- (void)didDetectCodes:(NSArray *)codes {

    //cc_13
}

- (NSArray *)transformedCodesFromCodes:(NSArray *)codes {

    //cc_14
    return nil;
}

- (UIBezierPath *)bezierPathForBounds:(CGRect)bounds {

    //cc_15
    return nil;
}

- (CAShapeLayer *)makeBoundsLayer {

    //cc_16

    return nil;
}

- (CAShapeLayer *)makeCornersLayer {

    //cc_17

    return nil;
}

- (UIBezierPath *)bezierPathForCorners:(NSArray *)corners {

    //cc_18
    return nil;
}

- (CGPoint)pointForCorner:(NSDictionary *)corner {

    //cc_19

    return CGPointZero;
}

@end
