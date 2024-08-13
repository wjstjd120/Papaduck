//
//  MypageViewController.swift
//  PapaDuck
//
//  Created by 신상규 on 8/13/24.
//

import UIKit

class MypageViewController: UIViewController {
    
    let mypageView = MypageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mypageView
        updateProgress()
        lvimageChange()
    }
    
    private func lvimageChange() {
        if mypageView.lvLabel.text == "Lv.2" {
            mypageView.lvImage.image = .lv2
        }
        
        if mypageView.lvLabel.text == "Lv.3" {
            mypageView.lvImage.image = .lv3
        }
        
        if mypageView.lvLabel.text == "Lv.4" {
            mypageView.lvImage.image = .lv4
        }
        
        if mypageView.lvLabel.text == "Lv.5" {
            mypageView.lvImage.image = .lv5
        }
    }
    
    private func updateProgress() {
        // exLabel의 텍스트를 "현재 경험치/최대 경험치"로 파싱합니다.
        let experienceText = mypageView.exLabel.text?.split(separator: "/")
        guard let currentExp = experienceText?.first, let maxExp = experienceText?.last,
              let currentExpValue = Float(currentExp), let maxExpValue = Float(maxExp) else {
            return
        }
        
        // 경험치에 따라 progressView 업데이트
        mypageView.exProgressView.progress = currentExpValue / maxExpValue
        
        // 경험치가 최대치에 도달하면 레벨업 처리
        if currentExpValue >= maxExpValue {
            // 레벨 증가
            if let currentLevel = Int(mypageView.lvLabel.text?.replacingOccurrences(of: "Lv.", with: "") ?? "1") {
                mypageView.lvLabel.text = "Lv.\(currentLevel + 1)"
            }
            
            // 경험치 초기화
            mypageView.exLabel.text = "0/\(Int(maxExpValue + 100))" // 경험치 최대치도 증가한다고 가정
            mypageView.exProgressView.progress = 0
        }
        
        // 경험치 증가 메서드를 추가하여 사용자가 경험치를 얻을 때 호출하는 것
        func setExperience(current: Int, max: Int) {
            mypageView.exLabel.text = "\(current)/\(max)"
            updateProgress()  // 진행 상태 업데이트
        }
    }
}
