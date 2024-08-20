//
//  UserDefaultsManager.swift
//  PapaDuck
//
//  Created by 신상규 on 8/19/24.
//

import Foundation

class UserDefaultsManager {
    private let defaults = UserDefaults.standard
    private let expKey = "userExperience"
    private let datesKey = "experienceDates"
    
    func getUserExperience() -> Int {
            // 예시 코드: 실제 저장된 경험치 값을 반환
            return UserDefaults.standard.integer(forKey: "userExperience")
        }

        func setUserExperience(exp: Int) {
            // 예시 코드: 경험치 값을 저장
            UserDefaults.standard.set(exp, forKey: "userExperience")
    }
    
    func getExperienceDates() -> [DateComponents] {
        if let data = defaults.data(forKey: datesKey),
           let dates = try? JSONDecoder().decode([DateComponents].self, from: data) {
            return dates
        }
        return []
    }
    
    func setExperienceDates(dates: [DateComponents]) {
        if let data = try? JSONEncoder().encode(dates) {
            defaults.set(data, forKey: datesKey)
        }
    }
}
