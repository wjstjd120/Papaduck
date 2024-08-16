//
//  MainView.swift
//  PapaDuck
//
//  Created by 이주희 on 8/12/24.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func mainView(_ mainView: MainView, didSelectBook book: WordsBookEntity)
    func mainViewDidRequestAddWord(_ mainView: MainView)
}

class MainView: UIView {
    weak var delegate: MainViewDelegate?
    var data = [WordsBookEntity]()
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView(image: UIImage(named: "Logo"))
    private let bubbleImageView = UIImageView(image: UIImage(named: "bubble"))
    let addLabel = UILabel()
    private let paduckImageView = UIImageView(image: UIImage(named: "papaduck"))
    private let dataEmptyView = UIView()
    let vocabularyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var addVocaButton = UIButton()
    private let dataStateView = UIView()
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupView() {
        titleLabel.text = "PAPADUCK"
        titleLabel.font = FontNames.mainFont.font()
        titleLabel.textColor = UIColor.subBlue
        titleLabel.textAlignment = .center
        
        addLabel.text = "단어장을 만들으세요..."
        addLabel.font = FontNames.main2Font2.font()
        addLabel.textColor = UIColor.black
        addLabel.isUserInteractionEnabled = true
        
        addVocaButton.backgroundColor = UIColor.mainYellow
        addVocaButton.setTitle("단어장 추가", for: .normal)
        addVocaButton.setTitleColor(.white, for: .normal)
        addVocaButton.layer.cornerRadius = 8
        addVocaButton.addTarget(self, action: #selector(didTapAddVocaButton), for: .touchUpInside)
        
        [titleLabel, logoImageView, dataEmptyView, dataStateView].forEach { addSubview($0)}
        [bubbleImageView, paduckImageView, addLabel].forEach { dataEmptyView.addSubview($0)}
        [vocabularyCollectionView, addVocaButton].forEach { dataStateView.addSubview($0)}
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(20)
        }
        
        logoImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalToSuperview().offset(40)
            $0.width.height.equalTo(50)
        }
        
        dataStateView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        vocabularyCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dataEmptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(300)
            $0.width.equalTo(200)
            $0.height.equalTo(100)
        }
        
        addLabel.snp.makeConstraints {
            $0.center.equalTo(bubbleImageView.snp.center)
        }
        
        paduckImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bubbleImageView.snp.bottom).offset(20)
            $0.width.equalTo(300)
            $0.height.equalTo(200)
        }
    }
    
    private func setupCollectionView() {
        vocabularyCollectionView.dataSource = self
        vocabularyCollectionView.delegate = self
        vocabularyCollectionView.register(VocaCollectionCell.self, forCellWithReuseIdentifier: "mainViewCollectioncell")
        vocabularyCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "addVocaCell")
    }
    
    // MARK: - Public Methods
    func updateView(forDataAvailability hasData: Bool) {
        dataEmptyView.isHidden = hasData
        dataStateView.isHidden = !hasData
    }
    
    func setData(_ data: [WordsBookEntity]) {
        self.data = data
        updateView(forDataAvailability: !data.isEmpty)
        vocabularyCollectionView.reloadData()
    }
    
    // MARK: - Actions
    @objc private func didTapAddVocaButton() {
        delegate?.mainViewDidRequestAddWord(self)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 셀의 개수를 반환합니다. 마지막에 추가 버튼을 위한 셀을 포함합니다.
        return data.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == data.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addVocaCell", for: indexPath)
            cell.contentView.addSubview(addVocaButton)
            addVocaButton.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(50)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainViewCollectioncell", for: indexPath) as! VocaCollectionCell
            let model = data[indexPath.row]
            cell.configure(with: model)
            cell.delegate = delegate as? VocaCollectionCellDelegate  // Delegate 설정
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = indexPath.row == data.count ? 50 : 100
        return CGSize(width: collectionView.bounds.width - 32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == data.count {
            delegate?.mainViewDidRequestAddWord(self)
        } else {
            let selectedBook = data[indexPath.row]
            delegate?.mainView(self, didSelectBook: selectedBook)
        }
    }
}
