//
//  MemorizeController.swift
//  PapaDuck
//
//  Created by 전성진 on 8/13/24.
//

import UIKit

import SnapKit

class MemorizeController: UIViewController {
    private var memorizeViews: [UIView] = []
    private var currentIndex: Int = 0
    private var memorizeView: MemorizeView!
    //    var animator: UIViewPropertyAnimator?
    
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
            }
            
            self.memorizeView.backgroundColor = .white
        })
    }
    
    private func configureViews() -> [UIView] {
        (0...30).map { index in
            let view = UIView()
            let label = UILabel()
            view.backgroundColor = .blue
            view.layer.cornerRadius = 20
            view.clipsToBounds = true
            label.text = "\(index) 번째 뷰"
            label.textColor = .black
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            return view
        }
    }
}
