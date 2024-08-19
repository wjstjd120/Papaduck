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
        return view
    }()
    
    let trueLabel: UILabel = {
        let label = UILabel()
        label.text = "외웠어요!"
        label.textColor = .subBlue3
        return label
    }()
    
    let falseLabel: UILabel = {
        let label = UILabel()
        label.text = "못외웠어요..."
        label.textColor = .subRed
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        [borderView, trueLabel, falseLabel].forEach {
            self.addSubview($0)
        }
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-120)
        }
        
        trueLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            $0.left.equalToSuperview().offset(20)
        }
        
        falseLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}
