//
//  mainViewCollectioncell.swift
//  PapaDuck
//
//  Created by 이주희 on 8/13/24.
//

import UIKit
import SnapKit

protocol VocaCollectionCellDelegate: AnyObject {
    func vocaCollectionCellDidTapEdit(_ cell: VocaCollectionCell)
}

class VocaCollectionCell: UICollectionViewCell {
    
    weak var delegate: VocaCollectionCellDelegate?
    
    private let vocaNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let wordCountLabel = UILabel()
    private lazy var editButton = UIButton()
    private let progressBarView = CircularProgressBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupCellAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        vocaNameLabel.font = FontNames.subFont.font()
        descriptionLabel.font = FontNames.thinFont2.font()
        wordCountLabel.font = FontNames.subFont4.font()
        wordCountLabel.textColor = UIColor.subBlue
        
        editButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        editButton.tintColor = .subBlue
        editButton.imageView?.contentMode = .scaleAspectFit
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        
        [vocaNameLabel, descriptionLabel, editButton, progressBarView, wordCountLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        vocaNameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(16)
            $0.leading.equalTo(contentView).inset(16)
            $0.trailing.lessThanOrEqualTo(progressBarView.snp.leading).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(vocaNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(vocaNameLabel)
            $0.trailing.equalTo(vocaNameLabel)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.trailing.equalTo(contentView.snp.trailing).inset(10)
        }
        
        progressBarView.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.height.equalTo(60)
            $0.trailing.equalTo(contentView).inset(32)
        }
        
        wordCountLabel.snp.makeConstraints {
            $0.center.equalTo(progressBarView)
        }
    }
    
    private func setupCellAppearance() {
        contentView.layer.backgroundColor = UIColor.subYellow.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.mainYellow.cgColor
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    func configure(with model: WordsBookEntity) {
        vocaNameLabel.text = model.wordsBookName
        descriptionLabel.text = model.wordsExplain
        
        let progress = 0.75
        let progressPercentage = Int(progress * 100)
        wordCountLabel.text = "\(progressPercentage)%"
        progressBarView.setProgress(diameter: 60, progress: progress)
    }
    
    @objc private func didTapEditButton() {
        delegate?.vocaCollectionCellDidTapEdit(self)
    }
}
