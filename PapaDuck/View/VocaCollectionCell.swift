//
//  mainViewCollectioncell.swift
//  PapaDuck
//
//  Created by 이주희 on 8/13/24.
//

import UIKit
import SnapKit

class VocaCollectionCell: UICollectionViewCell {
    private let vocaNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let wordCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        [vocaNameLabel, descriptionLabel, wordCountLabel].forEach { contentView.addSubview($0) }
        
        vocaNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(10)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(vocaNameLabel.snp.bottom)
            $0.leading.equalTo(vocaNameLabel)
            $0.trailing.equalTo(vocaNameLabel)
        }
        
        wordCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
   
}
