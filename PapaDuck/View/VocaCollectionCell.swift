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
    
    private var learenWordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private let learnedPerLabel: UILabel = {
        let label = UILabel()
        label.font = FontNames.subFont3.font()
        label.textColor = UIColor.subBlue
        return label
    }()
    
    private let wordCountLabel: UILabel = {
        let label = UILabel()
        label.font = FontNames.thinFont.font()
        label.textColor = UIColor.lightGray
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
        [vocaNameLabel, descriptionLabel, editButton, progressBarView, learenWordStackView].forEach { contentView.addSubview($0) }
        
        [learnedPerLabel, wordCountLabel].forEach { learenWordStackView.addArrangedSubview($0)
        }

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
            $0.width.height.equalTo(70)
            $0.trailing.equalTo(contentView).inset(32)
        }
        
        learenWordStackView.snp.makeConstraints { 
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
        // 단어장 이름과 설명 설정
        vocaNameLabel.text = model.wordsBookName
        descriptionLabel.text = model.wordsExplain

        // 단어장에 포함된 총 단어 수와 외운 단어 수를 가져옴
        let wordsCount = MainController().wordsCount(wordsBookId: model.wordsBookId ?? UUID())
        
        let totalWords = wordsCount.total
        let learnedWordsCount = wordsCount.learned
        
        // 외운 단어 비율 계산
        let learnedPercentage = totalWords > 0 ? (Double(learnedWordsCount) / Double(totalWords)) * 100 : 0
        
        // 외운 단어 비율 및 외운 단어/총 단어 수를 레이블에 표시
        wordCountLabel.text = "\(learnedWordsCount) / \(totalWords)"
        learnedPerLabel.text = "\(Int(learnedPercentage))%"
        
        // 진행 바에 비율 설정 (0 ~ 1 사이의 값으로 설정)
        let progress = Double(learnedPercentage) / 100.0
        progressBarView.setProgress(diameter: 70, progress: progress)
    }
    
    @objc private func didTapEditButton() {
        delegate?.vocaCollectionCellDidTapEdit(self)
        print("편집버튼 클릭")
    }
}
