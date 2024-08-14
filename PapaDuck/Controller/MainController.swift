//
//  ViewController.swift
//  PapaDuck
//
//  Created by 이주희 on 8/12/24.
//

import UIKit
import SnapKit

class MainController: UIViewController, MainViewDelegate {

    private let mainView = MainView()
    let coreData = WordsBookCoreDataManager()
//    var selectedBook: WordsBookModel?
    var wordsBookEntities: [WordsBookEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.delegate = self
        
        addTapGestureToLabel()
        loadWordsBooks()
        printWordsBookInfos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadWordsBooks()
    }
    

    private func addTapGestureToLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
        mainView.addLabel.addGestureRecognizer(tapGesture)
    }

    @objc private func handleLabelTap() {
        let createWordsController = CreateWordsController()
        navigationController?.pushViewController(createWordsController, animated: true)
    }

    func loadWordsBooks() {
         wordsBookEntities = coreData.retrieveWordsBookInfos()
        
        mainView.setData(wordsBookEntities)
    }
    
    func printWordsBookInfos() {
        let wordsBookEntities = coreData.retrieveWordsBookInfos()
        for entity in wordsBookEntities {
            print("ID: \(entity.objectID), Name: \(entity.wordsBookName ?? "Unknown"), Explanation: \(entity.wordsExplain ?? "Unknown")")
        }
    }

    func mainView(_ mainView: MainView, didSelectBook book: WordsBookEntity) {
        let wordListViewController = WordListViewController()
        wordListViewController.selectedBook = book
        navigationController?.pushViewController(wordListViewController, animated: true)
    }

    func mainViewDidRequestAddWord(_ mainView: MainView) {
        let createWordsController = CreateWordsController()
        navigationController?.pushViewController(createWordsController, animated: true)
    }
}
