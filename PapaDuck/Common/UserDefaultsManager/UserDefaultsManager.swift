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
        return defaults.integer(forKey: expKey)
    }
    
    func setUserExperience(exp: Int) {
        defaults.set(exp, forKey: expKey)
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
