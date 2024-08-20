//
//  ViewController.swift
//  PapaDuck
//
//  Created by 이주희 on 8/12/24.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    
    private let mainView = MainView()
    private let wordsBookCoreDataManager = WordsBookCoreDataManager()
    private let wordsCoreDataManager = WordsCoreDataManager()
    
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
    
    // MARK: - Setup Methods
    
    private func setupView() {
        view = mainView
        mainView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
        mainView.addLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Data Loading
    
    private func loadWordsBooks() {
        let wordsBookEntities = wordsBookCoreDataManager.retrieveWordsBookInfos()
        mainView.setData(wordsBookEntities)
    }
    
    // 프린트문 - 삭제가능
    private func printWordsBookInfos() {
        let wordsBookEntities = wordsBookCoreDataManager.retrieveWordsBookInfos()
        for entity in wordsBookEntities {
            print("ID: \(entity.objectID), Name: \(entity.wordsBookName ?? "Unknown"), Explanation: \(entity.wordsExplain ?? "Unknown")")
        }
    }
    
    //단어장의 단어 갯수 조회
    /// 단어장 UUID로 단어장에 포함되어있는 단어를 조회하는 메서드  - Returns: [단어]
    /// [단어] > 카운트
    /// - Parameter wordsBookId: 단어장 ID
    /// - Returns: 단어 개수
    func wordsCount(wordsBookId: UUID) -> (total: Int, learned: Int) {
        let words = wordsCoreDataManager.retrieveWordsBookInfos(wordsBookId: wordsBookId)
        let totalWords = words.count
        let learnedWords = words.filter { $0.memorizationYn }.count
        return (total: totalWords, learned: learnedWords)
    }
    
    // 단어장 총 단어 및 외운단어 조회
    /// 단어장 UUID 단어장 포함되어있는 단어조회 - Returns: [단어]
    /// 총 갯수 : [단어] > 카운트
    /// 외운단어 갯수 : filter [단어] > 카운트
    func learnedWordsPercentage(wordsBookId: UUID) -> Int {
            // 단어장에 포함된 모든 단어 조회
            let words = wordsCoreDataManager.retrieveWordsBookInfos(wordsBookId: wordsBookId)
            let totalWords = words.count
            
            // 외운 단어만 필터링
            let learnedWordsCount = words.filter { $0.memorizationYn }.count
            
            guard totalWords > 0 else {
                return 0 // 0으로 나누는 것을 피하기 위해 0 반환
            }
            
            // 외운 단어 비율 계산
            let learnedPercentage = (Double(learnedWordsCount) / Double(totalWords)) * 100
            
            return Int(learnedPercentage)
        }
    
    // MARK: - Actions
    
    @objc private func handleLabelTap() {
        let createWordsController = CreateWordsController()
        navigationController?.pushViewController(createWordsController, animated: true)
    }
}

// MARK: - MainViewDelegate
extension MainController: MainViewDelegate {
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

// MARK: - VocaCollectionCellDelegate
extension MainController: VocaCollectionCellDelegate {
    func vocaCollectionCellDidTapEdit(_ cell: VocaCollectionCell) {
        print("편집 버튼 클릭됨")
        
        if let indexPath = mainView.vocabularyCollectionView.indexPath(for: cell) {
            let selectedBook = mainView.data[indexPath.row]
            
            // 선택한 단어장 정보 출력
            print("선택된 단어장 - ID: \(selectedBook.wordsBookId ?? UUID()), 이름: \(selectedBook.wordsBookName ?? "알 수 없음"), 설명: \(selectedBook.wordsExplain ?? "알 수 없음")")
            let createWordsController = CreateWordsController()
            createWordsController.bookEntity = selectedBook
            createWordsController.setUpdateBook(entity: selectedBook)
            navigationController?.pushViewController(createWordsController, animated: true)
        } else {
            print("셀의 인덱스 경로를 찾을 수 없음")
        }
    }
}
