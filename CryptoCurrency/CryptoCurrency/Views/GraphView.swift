 //
 //  GraphView.swift
 //  CryptoCurrency
 //
 //  Created by Kaitlyn Barker on 6/20/18.
 //  Copyright © 2018 Kaitlyn Barker. All rights reserved.
 //
 
 import UIKit
 
 class GraphView: UIView {
    let lineLayer = CAShapeLayer()
    let circleLayer = CAShapeLayer()
    
    var chartTransform: CGAffineTransform?
    
    // IBInspectables are for seeing the properties in the storyboard
    @IBInspectable var lineColor: UIColor = UIColor.blue {
        didSet {
            lineLayer.strokeColor = lineColor.cgColor
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1
    
    // if the graphic can show the points or not
    @IBInspectable var showPoints: Bool = true {
        didSet {
            circleLayer.isHidden = !showPoints
        }
    }
    
    @IBInspectable var circleColor: UIColor = UIColor.cyan {
        didSet {
            circleLayer.fillColor = circleColor.cgColor
        }
    }
    
    @IBInspectable var circleSizeMultiplier: CGFloat = 3
    
    // for the grid
    @IBInspectable var axisColor: UIColor = UIColor.white
    
    @IBInspectable var showInnerLines: Bool = true
    
    @IBInspectable var labelFontSize: CGFloat = 10
    
    var axisLineWidth: CGFloat = 1
    var deltaX: CGFloat = 10 // distance between the points on the lines
    var deltaY: CGFloat = 10
    var xMax: CGFloat = 24 // max # in the x axis
    var yMax: CGFloat = 100000000
    var xMin: CGFloat = 0
    var yMin: CGFloat = 0
    
    // property where we will store the points that we will plot
    
    var data: [CGPoint]?
    
    // MARK: - Inits - MANDATORY FOR CUSTOM VIEWS
    
    // init with frame
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        combineInit()
    }
    
    // init with color
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        combineInit()
    }
    
    // MARK: - Funcs
    
    // layout the views so that we can update the views
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineLayer.frame = bounds
        circleLayer.frame = bounds
        
        if let data = data {
            // apply transform
            self.setTransform(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax)
            
            // plot graph
            self.plot(data)
        }
    }
    
    func setAxisRange(forPoints points: [CGPoint]) {
        // this is doing it for the max of all of the points
        // extract the points, make sure they aren't empty
        
        guard !points.isEmpty else { return }
        let xPoints = points.map { $0.x } // applies a formula to an array and tells it to do the formula to all of the values
        let yPoints = points.map { $0.y }
        
        // ceil rounds to the next highest number
        
        xMax = ceil(xPoints.max()! / deltaX) * deltaX
        yMax = ceil(yPoints.max()! / deltaY) * deltaY
        xMin = 0
        yMin = 0
        
        // set transform
        self.setTransform(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax)
    }
    
    func setAxisRange(xMin: CGFloat, xMax: CGFloat, yMin: CGFloat, yMax: CGFloat) {
        // this is doing it for one point
        self.xMin = xMin
        self.xMax = xMax
        self.yMin = yMin
        self.yMax = yMax
        
        // set transform - to reflect the changes
        self.setTransform(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax)
    }
    
    func setTransform(xMin: CGFloat, xMax: CGFloat, yMin: CGFloat, yMax: CGFloat) {
        let xLabelSize = "\(Int(xMax))".size(withSystemFontSize: labelFontSize)
        let yLabelSize = "\(Int(yMax))".size(withSystemFontSize: labelFontSize)
        
        let xOffSet = xLabelSize.height + 2 // separation between the labels
        let yOffSet = yLabelSize.width + 5
        
        let xScale = (self.bounds.width - yOffSet - xLabelSize.width/2 - 2)/(xMax - xMin)
        let yScale = (self.bounds.height - xOffSet - yLabelSize.height/2 - 2)/(yMax - yMin)
        
        self.chartTransform = CGAffineTransform(a: xScale, b: 0, c: 0, d: -yScale, tx: yOffSet, ty: self.bounds.height - xOffSet)
        self.setNeedsDisplay() // the rectangle needs to be redrawn.
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), let t = chartTransform else { return }
        
        self.drawAxes(in: context, usingTransform: t)
    }
    
    func combineInit() {
        layer.addSublayer(lineLayer)
        lineLayer.fillColor = UIColor.clear.cgColor // going to be transparent at the beginning
        lineLayer.strokeColor = lineColor.cgColor
        
        layer.addSublayer(circleLayer)
        circleLayer.fillColor = circleColor.cgColor
        
        layer.borderWidth = 1
        layer.borderColor = axisColor.cgColor // this is for the view that we are putting the graphic on.
    }
    
    func plot(_ points: [CGPoint]) {
        lineLayer.path = nil
        circleLayer.path = nil
        data = nil
        
        guard !points.isEmpty else { return }
        
        self.data = points
        
        if self.chartTransform == nil {
            debugPrint("chart transform is nil", #file, #function)
            setAxisRange(forPoints: points)
        }
        
        let linePath = CGMutablePath()
        
        guard let transform = chartTransform else { debugPrint("Chart Transform isnt cooperating"); return }
        linePath.addLines(between: points, transform: transform) // we are only force unwrapping it because we know that it won't be nil
        
        lineLayer.path = linePath
        
        if showPoints {
            circleLayer.path = circles(atPoints: points, withTransform: transform)
        }
    }
    
    func circles(atPoints points: [CGPoint], withTransform t: CGAffineTransform) -> CGPath {
        let path = CGMutablePath()
        let radius = lineLayer.lineWidth * circleSizeMultiplier/2
        
        for i in points {
            let p = i.applying(t)
            let rect = CGRect(x: p.x - radius, y: p.y - radius, width: radius * 2, height: radius * 2)
            
            path.addEllipse(in: rect)
        }
        
        return path
    }
    
    func drawAxes(in context: CGContext, usingTransform t: CGAffineTransform) {
        // draws the grid
        context.saveGState() // kind of like doing art on a scratch paper to practice. then we merge when we are sure we have what we want. THIS IS TO CREATE THE SCRATCH PAPER
        
        let thickerLines = CGMutablePath()
        let thinnerLines = CGMutablePath()
        
        let xAxisPoints = [CGPoint(x: xMin, y: 0), CGPoint(x: xMax, y: 0)] // lines inbetween the dots
        let yAxisPoints = [CGPoint(x: 0, y: yMin), CGPoint(x: 0, y: yMax)]
        
        thickerLines.addLines(between: xAxisPoints, transform: t)
        thickerLines.addLines(between: yAxisPoints, transform: t)
        
        // stride returns a sequence for x-n values.
        for x in stride(from: xMin, to: xMax, by: deltaX) {
            let thickPoints = showInnerLines ? [CGPoint(x: x, y: yMin).applying(t), CGPoint(x: x, y: yMax).applying(t)] : [CGPoint(x: x, y: 0).applying(t), CGPoint(x: x, y: 0).applying(t).adding(y: -5)] // second part is if we need to hide the element
            
            thinnerLines.addLines(between: thickPoints)
            
            if x != xMin {
                let label = "\(Int(x))" as NSString
                let labelSize = "\(Int(x))".size(withSystemFontSize: labelFontSize)
                let labelDrawPoint = CGPoint(x: x, y: 0).applying(t).adding(x: -labelSize.width/2).adding(y: 1)
                
                label.draw(at: labelDrawPoint, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: labelFontSize), NSAttributedStringKey.foregroundColor: axisColor])
            }
        }
        
        for y in stride(from: yMin, to: yMax, by: deltaY) {
            let thickPoints = showInnerLines ? [CGPoint(x: xMin, y: y).applying(t), CGPoint(x: xMax, y: y).applying(t)] : [CGPoint(x: 0, y: y).applying(t), CGPoint(x: 0, y: y).applying(t).adding(x: 5)]
            
            thinnerLines.addLines(between: thickPoints)
            
            if y != yMin {
                let label = "\(Int(y))" as NSString
                let labelSize = "\(Int(y))".size(withSystemFontSize: labelFontSize)
                let labelDrawPoint = CGPoint(x: 0, y: y).applying(t).adding(x: -labelSize.width - 1).adding(y: -labelSize.height/2)
                
                label.draw(at: labelDrawPoint, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: labelFontSize), NSAttributedStringKey.foregroundColor: axisColor])
            }
        }
        
        context.setStrokeColor(axisColor.cgColor)
        context.setLineWidth(axisLineWidth)
        context.addPath(thickerLines)
        context.strokePath()
        
        context.setStrokeColor(axisColor.withAlphaComponent(0.5).cgColor)
        context.setLineWidth(axisLineWidth/2)
        context.addPath(thinnerLines)
        context.strokePath()
        
        context.restoreGState()
    }
 }
 
 extension String {
    // size function - will help us create the graph so that we can update the size of the font so everything fits.
    
    func size(withSystemFontSize pointSize: CGFloat) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: pointSize)])
    }
 }
 
 extension CGPoint {
    func adding(x: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y)
    }
    
    func adding(y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y + y)
    }
 }
