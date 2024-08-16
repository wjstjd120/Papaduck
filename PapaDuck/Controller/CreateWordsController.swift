//
//  CreateWordsController.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//

import Foundation
import UIKit
class CreateWordsController: UIViewController{
    let createWordsView = CreateWordsView()
    let bookCoreData = WordsBookCoreDataManager()
    let wordCoreData = WordsCoreDataManager()
    var wordBookUUID: UUID?
    var bookEntity: WordsBookEntity?
    var wordEntity: WordsEntity?
    override func loadView() {
        view = createWordsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCreateWordsBookAction()
    }
    /// 기본적으로 셋팅되는 단어장 저장하는 Action설정
    func setCreateWordsBookAction(){
        createWordsView.saveButton.addTarget(self, action: #selector(save), for: .touchDown)
        createWordsView.deleteButton.addTarget(self, action: #selector(deleteCoreData), for: .touchDown)
    }
    
    /// 단어장 밑 단어 삭제 메서드
    @objc func deleteCoreData(){
        if let bookEntity = bookEntity{
            bookCoreData.deleteWordsBook(wordsBookId: bookEntity.wordsBookId!)
        }else if let wordEntity = wordEntity{
            wordCoreData.deleteWord(wordsBookId: wordEntity.wordsBookId!, word: wordEntity.word!)
        }
        navigationController?.popViewController(animated: true)
    }
    
    /// 단어장 밑 저장
    @objc func save(){
        if createWordsView.wordsBookNameTextField.text!.isEmpty{
            createWordsView.errorLabel.text = "필수 항목 입니다."
            self.createWordsView.wordsBookNameTextField.becomeFirstResponder()
            return
        }
        saveCoreData()
    }
    
    /// 단어장UUID가 있을 경우에는 단어 저장 아니면 단어장 저장
    @objc func saveCoreData() {
        
        if let bookEntity = bookEntity{
            //단어장 수정
            bookCoreData.updateWordsBook(wordsBookId: bookEntity.wordsBookId!, newWordsBookName: createWordsView.wordsBookNameTextField.text!, newWordsExplain: createWordsView.explanationTextField.text ?? "")
        }else if let wordEntity = wordEntity {
            //단어 수정
            createWordsView.deleteButton.isHidden = false
            wordCoreData.updateWords(entity: wordEntity, newWords: createWordsView.wordsBookNameTextField.text!, newWordsMeaning: createWordsView.explanationTextField.text ?? "", memorizationYn: wordEntity.memorizationYn)
        }else{
            if let wordBookUUID = wordBookUUID {
                // 단어 저장
                wordCoreData.saveWords(wordsBookId: wordBookUUID, word: createWordsView.wordsBookNameTextField.text!, meaning: createWordsView.explanationTextField.text ?? "")
                print("단어 저장됨")
            } else {
                // 단어장 저장
                bookCoreData.saveWordsBooks(wordsBookName: createWordsView.wordsBookNameTextField.text!, wordsExplain: createWordsView.explanationTextField.text ?? "")
                print("단어장 저장됨")
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
  
    
    /// 단어 저장하기 위해서 프로퍼티 변경
    /// - Parameters:
    ///   - wordBookId: 단어장 ID (UUID)
    ///   - wordBookName: 단어장 이름
    func setCreateWord(wordBookId: UUID, wordBookName: String){
        createWordsView.titleLabel.text = wordBookName
        createWordsView.wordsBookLabel.text = "단어"
        createWordsView.wordsBookNameTextField.placeholder = "단어를 입력해주세요"
        createWordsView.explanationLabel.text = "뜻"
        createWordsView.explanationTextField.placeholder = "단어의 의미를 입력해주세요."
        wordBookUUID = wordBookId
        if let wordEntity = wordEntity{
            createWordsView.deleteButton.isHidden = false
            createWordsView.wordsBookNameTextField.text = wordEntity.word
            createWordsView.explanationTextField.text = wordEntity.meaning
        }
    }
    
    
    /// 단어장 수정화면으로 전환하기위한 메서드
    /// - Parameter etity: 선택된 단어장 entity
    func setUpdateBook(entity: WordsBookEntity){
        bookEntity = entity
        createWordsView.deleteButton.isHidden = false
        createWordsView.wordsBookNameTextField.text = entity.wordsBookName
        createWordsView.explanationTextField.text = entity.wordsExplain
    }
}
