//
//  WordsCoreDataManager.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//

import Foundation
import UIKit
import CoreData
class WordsCoreDataManager{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    /// 단어를 저장하는 메서드
    /// - Parameters:
    ///   - wordsBookId: 단어장 ID
    ///   - word: 단어
    ///   - meaning: 단어 뜻
    func saveWords(wordsBookId: UUID?, word: String, meaning: String) {
        let words = WordsEntity(context: context)
        words.wordsBookId = wordsBookId
        words.word = word
        words.meaning = meaning
        words.memorizationYn = false
        do {
            try context.save()
            print("저장 성공")
        } catch {
            print("에러: \(error.localizedDescription)")
        }
    }
    
    
    /// 단어장 UUID로 단어장에 포함되어있는 단어를 조회하는 메서드
    /// - Parameter wordsBookId: 단어장 ID
    /// - Returns: [단어]
    func retrieveWordsBookInfos(wordsBookId: UUID) -> [WordsEntity] {
        let fetchRequest: NSFetchRequest<WordsEntity> = WordsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@", wordsBookId as CVarArg)
        do {
            let wordsBook = try context.fetch(fetchRequest)
            return wordsBook
        } catch {
            print("에러: \(error.localizedDescription)")
            return []
        }
    }
}
