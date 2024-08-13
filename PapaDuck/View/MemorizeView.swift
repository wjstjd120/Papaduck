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
        view.backgroundColor = .red
        return view
    }()
    
    let wordView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.text = "apple"
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
        borderView.addSubview(wordView)
        self.addSubview(borderView)
        wordView.addSubview(wordLabel)
        
        borderView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(40)
            $0.left.right.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-120)
        }
        
        wordView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-80)
        }
        
        wordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
