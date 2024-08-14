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
    let coreData = WordsBookCoreDataManager()
    override func loadView() {
        view = createWordsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setAction()
    }
    func setAction(){
        createWordsView.saveButton.addTarget(self, action: #selector(saveCoreData), for: .touchDown)
    }
//    @objc func saveCoreData(){
//        coreData.saveWordsBooks(wordsBookName: createWordsView.wordsBookNameTextField.text!, wordsExplain: createWordsView.wordsBookNameTextField.text ?? "")
//    }
//    
    @objc func saveCoreData() {
        let wordsBookName = createWordsView.wordsBookNameTextField.text ?? ""
        let wordsExplain = createWordsView.wordsBookNameTextField.text ?? ""
        
        if wordsBookName.isEmpty {
            print("Error: WordsBook name is empty. Cannot save to Core Data.")
            return
        }
        
        coreData.saveWordsBooks(wordsBookName: wordsBookName, wordsExplain: wordsExplain)
        
        // 저장된 데이터 가져오기
        let savedWordsBooks = coreData.retrieveWordsBookInfos()
        
        // 최근 저장된 단어장 출력
        if let lastSavedBook = savedWordsBooks.last {
            print("ID: \(lastSavedBook.wordsBookId ?? UUID()), Name: \(lastSavedBook.wordsBookName ?? ""), Explanation: \(lastSavedBook.wordsExplain ?? "")")
        } else {
            print("No WordsBooks saved.")
        }
    }
}
