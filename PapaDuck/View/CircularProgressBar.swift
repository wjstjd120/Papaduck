//
//  CircularProgressBar.swift
//  PapaDuck
//
//  Created by 이주희 on 8/14/24.
//
import UIKit

class CircularProgressBar: UIView {
    
    private let lineWidth: CGFloat = 4

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        let radius = (rect.width - lineWidth) / 2
        path.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY),
                    radius: radius,
                    startAngle: 0,
                    endAngle: 2 * .pi,
                    clockwise: true)
        path.lineWidth = lineWidth
        UIColor.lightGray.set()
        path.stroke()
    }
    
    func setProgress(diameter: CGFloat, progress: Double) {
        backgroundColor = .clear
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        let radius = (diameter - lineWidth) / 2
        let startAngle = CGFloat.pi / 2
        let endAngle = (.pi * 2) * CGFloat(progress) - startAngle
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: diameter / 2, y: diameter / 2),
                                        radius: radius,
                                        startAngle: -startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        
        let circularLayer = CAShapeLayer()
        circularLayer.path = circularPath.cgPath
        circularLayer.fillColor = UIColor.clear.cgColor
        circularLayer.strokeColor = UIColor.subBlue.cgColor
        circularLayer.lineWidth = lineWidth
        circularLayer.lineCap = .round
        
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layer.addSublayer(circularLayer)

    }
}
