//
//  MypageViewController.swift
//  PapaDuck
//
//  Created by 신상규 on 8/13/24.
//

import UIKit
import SnapKit

class MypageViewController: UIViewController {
    
    let mypageView = MypageView()
    var selectedDate: DateComponents? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mypageView
        updateProgress()
        lvimageChange()
        reloadDateView(date: Date())
        calendar()
    }
    
    //레벨별 고라파덕 머리심어주는 함수
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
        // exLabel의 텍스트를 "현재 경험치/최대 경험치"로 반환
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
            
            // 경험치 초기화후 레벨업
            mypageView.exLabel.text = "0/\(Int(maxExpValue + 100))" // 경험치 최대치도 증가한다고 가정
            mypageView.exProgressView.progress = 0
            lvimageChange()
        }
        
        // 경험치 증가 메서드를 추가하여 사용자가 경험치를 얻을 때 호출하는 것
        func setExperience(current: Int, max: Int) {
            mypageView.exLabel.text = "\(current)/\(max)"
            updateProgress()  // 진행 상태 업데이트
        }
    }
    
    private func calendar() {
        mypageView.calendarView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        mypageView.calendarView.selectionBehavior = dateSelection
    }
    
    private func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        mypageView.calendarView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}



extension MypageViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    // 달력의 특정 날짜에 대해 장식을 반환하는 역할
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let selectedDate = selectedDate, selectedDate == dateComponents {
            return .customView {
                let selectImage = UIImageView(image: UIImage(named: "Logo"))
                
                let containerView = UIView()
                containerView.addSubview(selectImage)
                
                selectImage.snp.makeConstraints{
                    $0.size.equalTo(15)
                    $0.center.equalTo(containerView)
                }
                return containerView
            }
        }
        return nil
    }
    
    // 값이 들어왔을때 날짜에 장식을 넣어주는 효과
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }
}
