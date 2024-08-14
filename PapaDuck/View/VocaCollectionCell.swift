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
        label.font = FontNames.subFont.font()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontNames.thinFont2.font()
        return label
    }()
    
    private let wordCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCellAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
         [vocaNameLabel, descriptionLabel, wordCountLabel].forEach { contentView.addSubview($0) }
         
         vocaNameLabel.snp.makeConstraints {
             $0.top.equalTo(contentView).inset(10)
             $0.leading.equalTo(contentView).inset(16)
             $0.trailing.lessThanOrEqualTo(wordCountLabel.snp.leading).offset(-8)
         }
         
         descriptionLabel.snp.makeConstraints {
             $0.top.equalTo(vocaNameLabel.snp.bottom).offset(8)
             $0.leading.equalTo(vocaNameLabel)
             $0.trailing.equalTo(vocaNameLabel)
         }
         
         wordCountLabel.snp.makeConstraints {
             $0.trailing.equalTo(contentView).inset(16)
             $0.centerY.equalTo(descriptionLabel.snp.centerY)
         }
     }
    
    private func setupCellAppearance() {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.gray.cgColor
            contentView.layer.cornerRadius = 8
            contentView.layer.masksToBounds = true
        }
    
    func configure(with model: WordsBookModel) {
        vocaNameLabel.text = model.name
        descriptionLabel.text = model.Explain
        wordCountLabel.text = "\(model.wordCount)"
    }
    
    
}
