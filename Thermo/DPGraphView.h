//
//  GraphView.h
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    DPGraphTypeContinuous,
    DPGraphTypeDiscrete,
    DPGraphTypeHistogramLine,
    DPGraphTypeHistogramBar,
} DPGraphType;

@class DPGraphView;
@protocol DPGraphViewDataSource <NSObject>

- (DPGraphType) graphView:(DPGraphView *)graphView typeOfPlotForIndex:(NSInteger)plotIndex;

// Continuous plot
- (CGFloat) graphView:(DPGraphView *)graphView yValueForXValue:(CGFloat)x onPlotWithIndex:(NSInteger)plotIndex;

// Discrete plot
- (NSInteger) graphView:(DPGraphView *)graphView numberOfPointsForIndex:(NSInteger)plotIndex;
- (CGPoint) graphView:(DPGraphView *)graphView xyValueForPointIndex:(NSInteger)pointIndex forPlotIndex:(NSInteger)plotIndex;

// Histogram
- (CGFloat) graphView:(DPGraphView *)graphView histogramHeightForStart:(CGFloat)start end:(CGFloat)end onPlotWithIndex:(NSInteger)plotIndex;

- (NSInteger) numberOfPlotsInGraphView:(DPGraphView *)graphView;

- (NSString *) XAxisLabelInGraphView:(DPGraphView *)graphView;
- (NSString *) YAxisLabelInGraphView:(DPGraphView *)graphView;

@optional

- (UIColor *) graphView:(DPGraphView *)graphView colorForPlotIndex:(NSUInteger)plotIndex;
- (UIColor *) colorForGridInGraphView:(DPGraphView *)graphView;

- (UIColor *) colorForXAxisInGraphView:(DPGraphView *)graphView;
- (UIColor *) colorForYAxisInGraphView:(DPGraphView *)graphView;

- (UIColor *) colorForAxesLabelsInGraphView:(DPGraphView *)graphView;

@end

@interface DPGraphView : UIView

@property (nonatomic, weak) id<DPGraphViewDataSource> dataSource;

// Graphing properties
@property (nonatomic) double minX;
@property (nonatomic) double maxX;

@property (nonatomic) double minY;
@property (nonatomic) double maxY;

@property (nonatomic) int numberOfHistogramBars;

@property (nonatomic) BOOL displayGridlines;
@property (nonatomic) BOOL dashGridlines;
@property (nonatomic) BOOL displayAxes;

@property (nonatomic) BOOL displayAsBoxedPlot; // Disables axes, enables a solid line around the graph view, and put labels on the sides of those lines - Common for engineering applications

- (CGFloat) getHistogramHeightForStart:(CGFloat)start end:(CGFloat)end onPlotWithIndex:(NSInteger)plotIndex;
- (void) startNewHistogramCycle;

@end
