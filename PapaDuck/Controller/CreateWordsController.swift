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
        createWordsView.saveButton.addTarget(self, action: #selector(saveBook), for: .touchDown)
    }
    
    /// 단어 저장을 위한 Action설정
    func setCreateWordsAction(){
        createWordsView.saveButton.removeTarget(nil, action: nil, for: .allEvents)
        createWordsView.saveButton.addTarget(self, action: #selector(saveWord), for: .touchDown)
    }
    
    
    /// 단어장을 저장하는 메서드
    @objc func saveBook(){
        bookCoreData.saveWordsBooks(wordsBookName: createWordsView.wordsBookNameTextField.text!, wordsExplain: createWordsView.wordsBookNameTextField.text ?? "")
    }
    
    /// 단어를 저장하는 메서드
    @objc func saveWord(){
        wordCoreData.saveWords(wordsBookId: wordBookUUID, word: createWordsView.wordsBookNameTextField.text!, meaning: createWordsView.wordsBookNameTextField.text ?? "")
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
        setCreateWordsAction()
    }
}
