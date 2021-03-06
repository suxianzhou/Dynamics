


#import <UIKit/UIKit.h>

typedef void(^TapBlock)();

@interface JXDynamics : UIView

@property (strong,nonatomic) CAShapeLayer *lineLayer;
@property (assign,nonatomic) CGFloat lineLength;
@property (strong,nonatomic) UIColor *lineColor;
@property (assign,nonatomic) CGFloat lineWidth;
@property (assign,nonatomic) CGFloat damping;
@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic) UIAttachmentBehavior *attach;
@property (strong,nonatomic) UIDynamicItemBehavior *itemBehaviour;
@property (strong,nonatomic) UICollisionBehavior *collision;

@property (copy,nonatomic) TapBlock tapBlock;

-(void)setUpWithAnchor:(CGPoint)anchor inView:(UIView*)view;

@end
