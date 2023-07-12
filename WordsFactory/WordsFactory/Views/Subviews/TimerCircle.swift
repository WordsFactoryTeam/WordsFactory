//
//  TimerCircle.swift
//  WordsFactory
//
//  Created by Антон Нехаев on 02.07.2023.
//

import UIKit

struct TimerCircleConsts {
    static let defaultMinValue: CGFloat = 0
    static let defaultMaxValue: CGFloat = 5
    static let fontSize: CGFloat = 40
}

class TimerCircle: UIView {
    private var minVal = TimerCircleConsts.defaultMinValue
    private var maxVal = TimerCircleConsts.defaultMaxValue
    private var cur = TimerCircleConsts.defaultMaxValue
    private var timer: Timer?
    private var complition: (() -> Void)?
    
    private let label: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"HelveticaNeue-Bold", size: TimerCircleConsts.fontSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getAngle(cur: CGFloat) -> CGFloat {
        let length = maxVal - minVal
        return 2 * CGFloat.pi * cur / length
        
    }
    
    private func updateCurLabel() {
        if cur == 0 {
            label.text = "GO!"
        } else {
            label.text = "\(Int(cur))"
        }
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath()
        let radius = min(bounds.width, bounds.height) / 2 - 15
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let endAngle = getAngle(cur: CGFloat(cur)) - CGFloat.pi / 2
        
        circlePath.addArc(withCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: endAngle, clockwise: true)
        
        let strokeColor = UIColor(named: "TimerArcColor") ?? UIColor.blue
        strokeColor.setStroke()
        circlePath.lineWidth = 15
        circlePath.lineCapStyle = .round
        
        circlePath.stroke()
    }
    
    func startTimer(complition: (() -> Void)?) {
        updateCurLabel()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        self.complition = complition
    }
    
    @objc private func updateTimer() {
        if cur > 0 {
            self.cur -= 1
            updateCurLabel()
            self.setNeedsDisplay()
        } else {
            timer?.invalidate()
            timer = nil
            complition?()
        }
    }
}

