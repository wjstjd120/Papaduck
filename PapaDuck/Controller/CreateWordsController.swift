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
    }
    
    @objc func save(){
        if createWordsView.wordsBookNameTextField.text!.isEmpty{
            createWordsView.errorLabel.text = "필수 항목 입니다."
            //self.createWordsView.wordsBookNameTextField.becomeFirstResponder()
            return
        }
        saveCoreData()
    }
    
    /// 단어장UUID가 있을 경우에는 단어 저장 아니면 단어장 저장
    @objc func saveCoreData() {
        if let wordBookUUID = wordBookUUID {
            // 단어 저장
            wordCoreData.saveWords(wordsBookId: wordBookUUID, word: createWordsView.wordsBookNameTextField.text!, meaning: createWordsView.explanationTextField.text ?? "")
            print("단어 저장됨")
        } else {
            // 단어장 저장
            bookCoreData.saveWordsBooks(wordsBookName: createWordsView.wordsBookNameTextField.text!, wordsExplain: createWordsView.explanationTextField.text ?? "")
            print("단어장 저장됨")
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
    }
}
