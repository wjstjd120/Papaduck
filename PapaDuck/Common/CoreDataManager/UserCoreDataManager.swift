//
//  UserCoreDataManager.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//

import Foundation
import CoreData
import UIKit
class UserCoreDataManager{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    /// 경험치 정보 조회
    /// - Returns: [경험치]
    func retrieveExp() -> [UserEntity]{
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let user = try context.fetch(fetchRequest)
            return user
        } catch {
            print("에러: \(error.localizedDescription)")
            return []
        }
    }
    
    /// 경험치 업데이트
    /// - Parameter plus: 업데이트 양
    func updateExp(plus: Int){
        var currentExp = retrieveExp()
            
        if let userEntity = currentExp.first {
            let currentExpValue = Int(userEntity.exp ?? "0") ?? 0
            let updatedExp = currentExpValue + plus
            userEntity.exp = String(updatedExp)
            
        } else {
            let newUserEntity = UserEntity(context: context)
            newUserEntity.exp = String(plus)
        }
        
        do {
            try context.save()
            print("경험치 업데이트 성공")
        } catch {
            print("경험치 업데이트 에러: \(error.localizedDescription)")
        }
    }
    
}
