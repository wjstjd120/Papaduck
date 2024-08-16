//
//  WordListViewController.swift
//  PapaDuck
//
//  Created by 내꺼다 on 8/13/24.
//

import UIKit
import CoreData

class WordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let wordListView = WordListView()
    var selectedBook: WordsBookEntity? {
        didSet {
            updateUIWithSelectedBook()
        }
    }
    
    private var words: [WordsEntity] = []
    
    
    override func loadView() {
        self.view = wordListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        let addBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addWord))
        navigationItem.rightBarButtonItem = addBarButton
        
        wordListView.tableView.delegate = self
        wordListView.tableView.dataSource = self
        wordListView.playButton.addTarget(self, action: #selector(playWord), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let book = selectedBook {
            loadWordsFromSelectedBook(book)
        }
    }
    
    private func updateUIWithSelectedBook() {
        if let book = selectedBook {
            self.navigationItem.title = book.wordsBookName ?? "Unknown"
            loadWordsFromSelectedBook(book)
        }
    }
    
    private func loadWordsFromSelectedBook(_ book: WordsBookEntity) {
        // CoreData에서 단어장 단어 불러오기
        let fetchRequest: NSFetchRequest<WordsEntity> = WordsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wordsBookId == %@", book.wordsBookId! as any CVarArg as CVarArg)
        
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            words = try context.fetch(fetchRequest)
            wordListView.tableView.reloadData()
        } catch {
            print("Failed to fetch words: \(error)")
        }
    }
    
    @objc func addWord() {
        if let book = selectedBook {
            // selectedBook을 사용하여 UI 업데이트
            print("Selected Book Name: \(book.wordsBookName ?? "Unknown")")
            print("Selected Book Explanation: \(book.wordsExplain ?? "Unknown")")
            
            let createWordsController = CreateWordsController()
            createWordsController.setCreateWord(wordBookId: book.wordsBookId ?? UUID(), wordBookName: book.wordsBookName ?? "")
            navigationController?.pushViewController(createWordsController, animated: true)
        }
    }
    
    @objc func playWord() {
        // 단어장 플레이 화면
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count // 수정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath) as? WordTableViewCell else {
            return UITableViewCell()
        }
        
        let word = words[indexPath.row]
        cell.wordLabel.text = word.word
        cell.meaningLabel.text = word.meaning
        cell.memorizeLabel.text = word.memorizationYn ? "암기" : "미암기"
        cell.memorizeLabel.textColor = word.memorizationYn ? UIColor.green : UIColor.red
        
        return cell
    }
    
    // 셀 선택 수정화면 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWord = words[indexPath.row]
        let createWordsController = CreateWordsController()
        
        // 단어 수정 모드로 설정
        createWordsController.wordEntity = selectedWord
        
        
         if let book = selectedBook {
             createWordsController.setCreateWord(wordBookId: book.wordsBookId!, wordBookName: book.wordsBookName ?? "기본 이름")
         }
        
        
        navigationController?.pushViewController(createWordsController, animated: true)
    }
}

//#Preview("WordListViewController") {
//    WordListViewController()
//}


// 화면 UI구성먼저
// 플레이버튼이 테이블뷰 위로 올라와야함..
// 저장된 데이터 불러와야하고 새로 생긴 데이터로 테이블뷰 업데이트
// viewWillAppear


