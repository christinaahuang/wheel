
import UIKit


public protocol PiechartDelegate {
    func setSubtitle(total: CGFloat, slice: Piechart.Slice) -> String
    func setInfo(total: CGFloat, slice: Piechart.Slice) -> String
}

public class Piechart: UIControl {
    
    // Slice
    public struct Slice {
        public var color: UIColor!
        public var value: CGFloat!
        public var text: String!
    }
    
    // Radius
    public struct Radius {
        public var inner: CGFloat = 0
        public var outer: CGFloat = 120
    }
    
    // Private
//    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var infoLabel: UILabel!
    private var total: CGFloat!
    
    
    /**
     * public
     */
    public var radius: Radius = Radius()
    public var activeSlice: Int = 0
    public var delegate: PiechartDelegate?
    
//    public var title: String = "title" {
//        didSet {
//            titleLabel.text = title
//        }
//    }
    
    
    public var slices: [Slice] = [] {
        didSet {
            total = 0
            for slice in slices {
                total = slice.value + total
            }
        }
    }
    
    
    // methods
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
//        self.addTarget(self, action: #selector(Piechart.click), forControlEvents: .TouchUpInside)
        
//        titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
//        titleLabel.textAlignment = .Center
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(titleLabel)
        
//        subtitleLabel = UILabel()
//        subtitleLabel.text = subtitle
//        subtitleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
//        subtitleLabel.textColor = UIColor.grayColor()
//        subtitleLabel.textAlignment = .Center
//        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(subtitleLabel)
//        
//        infoLabel = UILabel()
//        infoLabel.text = subtitle
//        infoLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
//        infoLabel.textColor = UIColor.grayColor()
//        infoLabel.textAlignment = .Center
//        infoLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(infoLabel)
        
//        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
//        self.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
//        
//        self.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .Top, relatedBy: .Equal, toItem: subtitleLabel, attribute: .Bottom, multiplier: 1, constant: 0))
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    public override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        var startValue: CGFloat = 0
        var startAngle: CGFloat = 0
        var endValue: CGFloat = 0
        var endAngle: CGFloat = 0
        
        for (index, slice) in slices.enumerate() {
            
            startAngle = (startValue * 2 * CGFloat(M_PI)) - CGFloat(M_PI_2)
            endValue = startValue + (slice.value / self.total)
            endAngle = (endValue * 2 * CGFloat(M_PI)) - CGFloat(M_PI_2)
            
            let path = UIBezierPath()
            path.moveToPoint(center)
            path.addArcWithCenter(center, radius: radius.outer, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            //if (index == activeSlice) {
            let color = slice.color
//                subtitle = delegate?.setSubtitle(self.total, slice: slice) ?? "subtitle"
//                info = delegate?.setInfo(self.total, slice: slice) ?? "info"
            //}
            color.setFill()
            path.fill()
            
            // increase start value for next slice
            startValue += slice.value / self.total
        }
    }
    
}