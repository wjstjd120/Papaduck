//
//  MemorizeView.swift
//  PapaDuck
//
//  Created by 전성진 on 8/13/24.
//

import UIKit

import SnapKit

class MemorizeView: UIView {
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    let trueLabel: UILabel = {
        let label = UILabel()
        label.text = "알아요"
        label.textColor = .subBlue3
        return label
    }()
    
    let falseLabel: UILabel = {
        let label = UILabel()
        label.text = "몰라요"
        label.textColor = .subRed
        return label
    }()
    
    let leftArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowshape.left.fill")
        imageView.tintColor = .gray
        return imageView
    }()
    
    let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowshape.right.fill")
        imageView.tintColor = .gray
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // layoutSubviews에서 테두리 추가 호출
        addDashedBorder(view: borderView)
    }
    
    private func configureUI() {
        [borderView, trueLabel, falseLabel, leftArrowImageView, rightArrowImageView].forEach {
            self.addSubview($0)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-200)
        }
        
        trueLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            $0.left.equalToSuperview().offset(20)
        }
        
        falseLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            $0.right.equalToSuperview().offset(-20)
        }
        
        leftArrowImageView.snp.makeConstraints {
            $0.left.equalTo(trueLabel.snp.right).offset(20)
            $0.centerY.equalTo(trueLabel.snp.centerY)
            $0.width.equalTo(40)
            $0.height.equalTo(30)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.right.equalTo(falseLabel.snp.left).offset(-20)
            $0.centerY.equalTo(trueLabel.snp.centerY)
            $0.width.equalTo(40)
            $0.height.equalTo(30)
        }

    }
    
    func addDashedBorder(view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.mainYellow.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineDashPattern = [6, 3] // [길이, 간격] - 점선 패턴 설정
        shapeLayer.fillColor = nil
        
        // 경로 설정 (뷰의 테두리 경로)
        let path = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius)
        shapeLayer.path = path.cgPath
        
        // 이미 기존 테두리가 있다면 제거
        view.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        
        // 새로운 점선 테두리 추가
        view.layer.addSublayer(shapeLayer)
    }
}
