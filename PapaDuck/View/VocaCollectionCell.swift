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
        label.font = FontNames.subFont4.font()
        label.textColor = UIColor.subBlue
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        button.tintColor = .subBlue
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return button
    }()
    
    private let progressBarView: CircularProgressBar = {
        let progressBar = CircularProgressBar()
        return progressBar
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
        [vocaNameLabel, descriptionLabel, editButton, progressBarView].forEach { contentView.addSubview($0) }
        
        contentView.addSubview(wordCountLabel)

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
        print("편집버튼 클릭")
    }
}
