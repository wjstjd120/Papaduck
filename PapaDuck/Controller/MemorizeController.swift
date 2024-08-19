//
//  MemorizeController.swift
//  PapaDuck
//
//  Created by 전성진 on 8/13/24.
//

import UIKit

import SnapKit

class MemorizeController: UIViewController {
    var wordsBookId: UUID?
    private var memorizeViews: [UIView] = []
    private var currentIndex: Int = 0
    private var memorizeView: MemorizeView!
    private let dataManager: WordsCoreDataManager = WordsCoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "단어장 외우기"
        memorizeView = MemorizeView()
        self.view = memorizeView
        
        memorizeViews = configureViews()
        
        // 첫 번째 뷰를 초기 설정
        if let firstView = memorizeViews.first {
            firstView.frame = self.view.bounds
            memorizeView.borderView.addSubview(firstView)
            firstView.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(40)
            }
        } else {
            emptyListAlert()
        }
        
        configureEvents()
    }
    
    private func configureEvents() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        memorizeView.borderView.addGestureRecognizer(swipeLeft)
        memorizeView.borderView.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        let direction: UISwipeGestureRecognizer.Direction = gesture.direction
        let isSwipingLeft = direction == .left
        
        // "외웠다" 또는 "못외웠다" 출력
        if isSwipingLeft {
            memorizeView.backgroundColor = .green
            print("외웠다")
        } else {
            memorizeView.backgroundColor = .red
            print("못외웠다")
        }
        
        // 현재 보여주고 있는 뷰를 삭제
        guard let currentView = memorizeViews.first else { return }
        
        // 다음 뷰 설정
        let translationX = isSwipingLeft ? -self.memorizeView.borderView.bounds.width : self.memorizeView.borderView.bounds.width
        
        // 애니메이션 적용
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            // 현재 뷰를 화면 밖으로 이동
            currentView.transform = CGAffineTransform(translationX: translationX, y: 0)
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            
            // 애니메이션 완료 후 이전 뷰를 제거
            currentView.removeFromSuperview()
            self.memorizeViews.removeFirst()
            
            // 다음 뷰가 있다면 추가
            if let nextView = self.memorizeViews.first {
                nextView.frame = self.memorizeView.borderView.bounds
                self.memorizeView.borderView.addSubview(nextView)
                nextView.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(40)
                }
            } else {
                emptyListAlert()
            }
            
            self.memorizeView.backgroundColor = .white
        })
    }
    
    private func emptyListAlert() {
        let alert = UIAlertController(title: "알림", message: "모든 단어를 확인하였습니다.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func configureViews() -> [UIView] {
        guard let id = wordsBookId else { return [] }
        
        var list: [WordsEntity] = dataManager.retrieveWordsBookInfos(wordsBookId: id)
        // 랜덤한 단어 나오게 셔플
        list.shuffle()
        
        return list.map { word in
            let view = UIView()
            let wordLabel = UILabel()
            let meaningLabel = UILabel()
            view.backgroundColor = .white
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            wordLabel.text = "\(word.word ?? "")"
            wordLabel.textColor = .black
            meaningLabel.text = "\(word.meaning ?? "")"
            meaningLabel.textColor = .black
            [wordLabel, meaningLabel].forEach {
                view.addSubview($0)
            }
            wordLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            meaningLabel.snp.makeConstraints {
                $0.centerX.equalTo(wordLabel.snp.centerX)
                $0.top.equalTo(wordLabel.snp.bottom).offset(30)
            }
            return view
        }
    }
}
