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
        calendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registrationNumbers()
        memorizingNumbers()
        lvimageChange()
        loadUserExperience()
        createWordMarkerToDateView()
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
    
    private func calculateMaxExp() -> Int {
        let currentLevel = Int(mypageView.lvLabel.text?.replacingOccurrences(of: "Lv.", with: "") ?? "1") ?? 1
        return 100 + (currentLevel - 1) * 100
    }

    private func loadUserExperience() {
        let userExp = userCoreDataManager.retrieveExp().first?.exp ?? "0"
        let currentExp = Int(userExp) ?? 0
        let maxExp = calculateMaxExp()
        
        mypageView.exLabel.text = "\(currentExp)/\(maxExp)"
        mypageView.exProgressView.progress = Float(currentExp) / Float(maxExp)
        
        if currentExp >= maxExp {
            levelUp()
        }
    }

    private func levelUp() {
        let currentLevel = Int(mypageView.lvLabel.text?.replacingOccurrences(of: "Lv.", with: "") ?? "1") ?? 1
        mypageView.lvLabel.text = "Lv.\(currentLevel + 1)"
        
        let newMaxExp = calculateMaxExp()
        
        mypageView.exLabel.text = "0/\(newMaxExp)"
        mypageView.exProgressView.progress = 0

        // 유저디폴트 경험치를 0으로 초기화
        userDefaultsManager.setUserExperience(exp: 0)

        if let userEntity = userCoreDataManager.retrieveExp().first,
           let currentExpInt = Int(userEntity.exp ?? "0") {
            // 현재 경험치의 음수 값을 전달하여 0으로 리셋
            userCoreDataManager.updateExp(plus: -currentExpInt)
        } else {
            // 만약 currentExp가 nil이라면, 0으로 리셋
            userCoreDataManager.updateExp(plus: 0)
        }
    }
    private func createWordMarkerToDateView() {
        
        let today = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        if !experienceDates.contains(today) {
            experienceDates.append(today)
            userDefaultsManager.setExperienceDates(dates: experienceDates) // 날짜 저장
        }
        reloadDateView(date: Calendar.current.date(from: today))
    }

    private func updateProgress() {
        let experienceText = mypageView.exLabel.text?.split(separator: "/")
        guard let currentExp = experienceText?.first, let maxExp = experienceText?.last,
              let currentExpValue = Float(currentExp), let maxExpValue = Float(maxExp) else {
            return
        }

        mypageView.exProgressView.progress = currentExpValue / maxExpValue
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
                    $0.size.equalTo(20)
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
