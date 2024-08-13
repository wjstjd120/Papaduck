//
//  WordsBookCoreDataManager.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//

import Foundation
import UIKit
import CoreData
class WordsBookCoreDataManager{
    static let shared = WordsBookCoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    ///단어장 저장하는 메서드
    func saveWordsBooks(wordsBookName: String, wordsExplain: String) {
        let wordsBook = WordsBookEntity(context: context)
        wordsBook.wordsBookId = UUID()
        wordsBook.wordsBookName = wordsBookName
        wordsBook.wordsExplain = wordsExplain
        do {
            try context.save()
            print("저장 성공")
        } catch {
            print("에러: \(error.localizedDescription)")
        }
    }
    
    ///단어장 전체 조회하는 메서드
    func retrieveWordsBookInfos() -> [WordsBookEntity] {
        let fetchRequest: NSFetchRequest<WordsBookEntity> = WordsBookEntity.fetchRequest()
        
        do {
            let wordsBook = try context.fetch(fetchRequest)
            return wordsBook
        } catch {
            print("에러: \(error.localizedDescription)")
            return []
        }
    }
    
}
