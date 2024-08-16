//
//  ViewController.swift
//  PapaDuck
//
//  Created by 이주희 on 8/12/24.
//

import UIKit
import SnapKit

class MainController: UIViewController, MainViewDelegate, VocaCollectionCellDelegate {
    private let mainView = MainView()
    private let coreData = WordsBookCoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadWordsBooks()
        printWordsBookInfos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWordsBooks()
    }
    
    private func setupView() {
        view = mainView
        mainView.delegate = self // MainController를 MainView의 delegate로 설정
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
        mainView.addLabel.addGestureRecognizer(tapGesture)
    }
    
    private func loadWordsBooks() {
        let wordsBookEntities = coreData.retrieveWordsBookInfos()
        mainView.setData(wordsBookEntities)
    }
    
    private func printWordsBookInfos() {
        let wordsBookEntities = coreData.retrieveWordsBookInfos()
        for entity in wordsBookEntities {
            print("ID: \(entity.objectID), Name: \(entity.wordsBookName ?? "Unknown"), Explanation: \(entity.wordsExplain ?? "Unknown")")
        }
    }
    
    @objc private func handleLabelTap() {
        let createWordsController = CreateWordsController()
        navigationController?.pushViewController(createWordsController, animated: true)
    }
    
    // MARK: - MainViewDelegate
    func mainView(_ mainView: MainView, didSelectBook book: WordsBookEntity) {
        let wordListViewController = WordListViewController()
        wordListViewController.selectedBook = book
        navigationController?.pushViewController(wordListViewController, animated: true)
    }
    
    func mainViewDidRequestAddWord(_ mainView: MainView) {
        let createWordsController = CreateWordsController()
        navigationController?.pushViewController(createWordsController, animated: true)
    }
    
    // MARK: - VocaCollectionCellDelegate
    extension MainController: VocaCollectionCellDelegate {
        func vocaCollectionCellDidTapEdit(_ cell: VocaCollectionCell) {
            if let indexPath = mainView.vocabularyCollectionView.indexPath(for: cell) {
                let selectedBook = mainView.data[indexPath.row]
                let createWordsController = CreateWordsController()
                
                // UUID를 직접 전달
                if let bookId = selectedBook.wordsBookId {
                    createWordsController.setCreateWord(wordBookId: bookId, wordBookName: selectedBook.wordsBookName ?? "")
                }
                
                navigationController?.pushViewController(createWordsController, animated: true)
            }
        }
    }
