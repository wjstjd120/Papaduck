//
//  MypageViewController.swift
//  PapaDuck
//
//  Created by 신상규 on 8/13/24.
//

import UIKit
import SnapKit
import CoreData

class MypageViewController: UIViewController {
    
    let wordsBookCoreDataManager = WordsBookCoreDataManager()
    let wordsCoreDataManager = WordsCoreDataManager()
    let mypageView = MypageView()
    var selectedDate: DateComponents? = nil
    var experienceDates: [DateComponents] = []
    let memorizeController = MemorizeController()
    let userCoreDataManager = UserCoreDataManager()
    let userDefaultsManager = UserDefaultsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mypageView
        updateProgress()
        lvimageChange()
        calendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registrationNumbers()
        memorizingNumbers()
        setExperience(max: 100)
    }
    
    // 총 등록단어 갯수 확인
    private func registrationNumbers() {
        let readAllDetaNumber = wordsCoreDataManager.retrieveAllWords().count
        mypageView.registrationnumber.text = "\(readAllDetaNumber)"
    }
    
    // 총 암기한 단어 갯수 확인
    private func memorizingNumbers() {
        let memorizedWords = wordsCoreDataManager.retrieveAllWords().filter { $0.memorizationYn == true }
        mypageView.memorizingnumber.text = "\(memorizedWords.count)"
    }
    
    // 레벨별 이미지 변경 함수
    private func lvimageChange() {
        switch mypageView.lvLabel.text {
        case "Lv.1":
            mypageView.lvImage.image = .lv1
        case "Lv.2":
            mypageView.lvImage.image = .lv2
        case "Lv.3":
            mypageView.lvImage.image = .lv3
        case "Lv.4":
            mypageView.lvImage.image = .lv4
        case "Lv.5":
            mypageView.lvImage.image = .lv5
        default:
            break
        }
    }
    
    // 경험치 레이블 /를 나눠주는 함수
    private func updateProgress() {
        let experienceText = mypageView.exLabel.text?.split(separator: "/")
        guard let currentExp = experienceText?.first, let maxExp = experienceText?.last,
              let currentExpValue = Float(currentExp), let maxExpValue = Float(maxExp) else {
            return
        }
        
        mypageView.exProgressView.progress = currentExpValue / maxExpValue
        
        // 경험치가 최대값에 도달했을 때 레벨업 처리
        if currentExpValue >= maxExpValue {
            if let currentLevel = Int(mypageView.lvLabel.text?.replacingOccurrences(of: "Lv.", with: "") ?? "1") {
                mypageView.lvLabel.text = "Lv.\(currentLevel + 1)"
            }
            mypageView.exLabel.text = "0/\(Int(maxExpValue + 100))"
            mypageView.exProgressView.progress = 0
            lvimageChange()
        }
    }
    
    // 경험치를 조회하고 조회가 완료되면 캘린더에 날짜 추가
    private func setExperience(max: Int) {
        let userExp = userCoreDataManager.retrieveExp().first?.exp ?? "0"
        let newExp = Int(userExp) ?? 0
        
        if newExp >= max {
            // 경험치가 최대치에 도달하면 레벨업
            let currentLevel = Int(mypageView.lvLabel.text?.replacingOccurrences(of: "Lv.", with: "") ?? "1") ?? 1
            mypageView.lvLabel.text = "Lv.\(currentLevel + 1)"
            mypageView.exLabel.text = "0/\(max + 100)"
            userDefaultsManager.setUserExperience(exp: 0) // 경험치 초기화
        } else {
            userDefaultsManager.setUserExperience(exp: newExp + 1) // 경험치 업데이트
            mypageView.exLabel.text = "\(newExp + 1)/\(max)"
        }
        
        updateProgress()
        print(updateProgress)
        
        let today = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        if !experienceDates.contains(today) {
            experienceDates.append(today)
            userDefaultsManager.setExperienceDates(dates: experienceDates) // 날짜 저장
        }
        reloadDateView(date: Calendar.current.date(from: today))
    }
    
    // 캘린더 초기화 및 설정
    private func calendar() {
        mypageView.calendarView.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        mypageView.calendarView.selectionBehavior = dateSelection
    }
    
    // 캘린더에서 날짜에 대해 데코레이션 업데이트
    private func reloadDateView(date: Date?) {
        guard let date = date else { return }
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        mypageView.calendarView.reloadDecorations(forDateComponents: [dateComponents], animated: true)
    }
}

extension MypageViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if experienceDates.contains(where: { $0.day == dateComponents.day && $0.month == dateComponents.month && $0.year == dateComponents.year }) {
            return .customView {
                let logoImage = UIImageView(image: UIImage(named: "Logo"))
                let containerView = UIView()
                containerView.addSubview(logoImage)
                logoImage.snp.makeConstraints {
                    $0.size.equalTo(15)
                    $0.center.equalTo(containerView)
                }
                return containerView
            }
        }
        return nil
    }
    
    // 날짜 선택 시 데코레이션 업데이트
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }
}
