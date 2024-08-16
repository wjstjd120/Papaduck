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
    let coreData = WordsCoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// 단어장 저장하는 메서드
    /// - Parameters:
    ///   - wordsBookName: 단어장 이름
    ///   - wordsExplain: 단어장 설명
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
    
    /// 단어장 전체 조회하는 메서드
    /// - Returns: [WordsBookEntity]
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
    
    /// 단어장 삭제 하는 메서드
    /// - Parameter wordsBookId: 단어장ID
    func deleteWordsBook(wordsBookId: UUID){
        let fetchRequest = WordsBookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@", wordsBookId as CVarArg)
        do{
            let result = try self.context.fetch(fetchRequest)
            for data in result as [NSManagedObject]{
                self.context.delete(data)
            }
            try self.context.save()
            coreData.deleteAllWord(wordsBookId: wordsBookId)
            print("삭제 성공")
        }catch{
            print("삭제 실패")
        }
    }
    
    func updateWordsBook(wordsBookId: UUID, newWordsBookName: String, newWordsExplain: String) {
        let fetchRequest: NSFetchRequest<WordsBookEntity> = WordsBookEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@", wordsBookId as CVarArg)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let wordsBook = result.first {
                wordsBook.wordsBookName = newWordsBookName
                wordsBook.wordsExplain = newWordsExplain
                
                try context.save()
                print("수정 성공")
            } else {
                print("단어장 찾을 수 없음")
            }
        } catch {
            print("수정 실패: \(error.localizedDescription)")
        }
    }
}
