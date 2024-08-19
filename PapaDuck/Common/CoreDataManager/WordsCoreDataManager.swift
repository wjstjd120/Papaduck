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
    
    /// 단어장에 있는 단어 전체 삭제
    /// - Parameter wordsBookId: 단어장ID
    func deleteAllWord(wordsBookId: UUID){
        let fetchRequest = WordsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@", wordsBookId as CVarArg)
        do{
            let result = try self.context.fetch(fetchRequest)
            for data in result as [NSManagedObject]{
                self.context.delete(data)
            }
            try self.context.save()
            print("삭제 성공")
        }catch{
            print("삭제 실패")
        }
    }
    
    /// 단어장에 있는 단어 하나 삭제 메서드
    /// - Parameters:
    ///   - wordsBookId: 단어장 ID
    ///   - word: 단어
    func deleteWord(wordsBookId: UUID, word: String){
        let fetchRequest = WordsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@ AND word == %@", wordsBookId as CVarArg, word)
        do{
            let result = try self.context.fetch(fetchRequest)
            for data in result as [NSManagedObject]{
                self.context.delete(data)
            }
            try self.context.save()
            print("삭제 성공")
        }catch{
            print("삭제 실패")
        }
    }
    
    /// 단어 수정 메서드
    /// - Parameters:
    ///   - entity: 기존에 있던 단어 entity
    ///   - newWords: 변경되는 단어
    ///   - newWordsMeaning: 변경되는 단어 의미
    ///   - memorizationYn: 변경되는 단어 암기 여부
    func updateWords(entity: WordsEntity, newWords: String, newWordsMeaning: String, memorizationYn: Bool) {
        let fetchRequest: NSFetchRequest<WordsEntity> = WordsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@ AND word == %@", entity.wordsBookId! as CVarArg, entity.word!)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let wordsBook = result.first {
                wordsBook.word = newWords
                wordsBook.meaning = newWordsMeaning
                wordsBook.memorizationYn = memorizationYn
                try context.save()
                print("수정 성공")
            } else {
                print("단어장 찾을 수 없음")
            }
        } catch {
            print("수정 실패: \(error.localizedDescription)")
        }
    }
    
    
    /// 단어 전체 조회
    /// - Returns: [단어]
    func retrieveAllWords() -> [WordsEntity] {
        let fetchRequest: NSFetchRequest<WordsEntity> = WordsEntity.fetchRequest()
        
        do {
            let words = try context.fetch(fetchRequest)
            return words
        } catch {
            print("에러: \(error.localizedDescription)")
            return []
        }
    }
    
    /// 단어장에 같은 단어가 있는지 확인하는 함수
    /// - Parameters:
    ///   - wordsBookId: 저장 할 단어장 ID
    ///   - word: 저장할 단어
    /// - Returns: 있는지 없는지
    func validateCheck(wordsBookId: UUID, word: String) -> Bool{
        let fetchRequest = WordsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@ AND word == %@", wordsBookId as CVarArg, word)
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("에러: \(error.localizedDescription)")
            return false
        }
    }
}
