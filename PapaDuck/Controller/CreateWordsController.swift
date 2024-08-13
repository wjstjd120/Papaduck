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
    @objc func saveCoreData(){
        coreData.saveWordsBooks(wordsBookName: createWordsView.wordsBookNameTextField.text!, wordsExplain: createWordsView.wordsBookNameTextField.text ?? "")
    }
    
}
