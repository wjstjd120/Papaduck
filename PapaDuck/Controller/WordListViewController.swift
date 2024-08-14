//
//  WordListViewController.swift
//  PapaDuck
//
//  Created by 내꺼다 on 8/13/24.
//

import UIKit

class WordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let wordListView = WordListView()
    var selectedBook: WordsBookModel?
    
    // 더미 데이터 - 테스트
    private var words: [Word] = [
        Word(word: "Apple", meaning: "사과", isMemorized: true),
        Word(word: "Banana", meaning: "바나나", isMemorized: false),
        Word(word: "Car", meaning: "자동차", isMemorized: false),
        Word(word: "Dog", meaning: "개", isMemorized: true)
    ]
    
    override func loadView() {
        self.view = wordListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addBarButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addWord))
        navigationItem.rightBarButtonItem = addBarButton
        
        wordListView.tableView.delegate = self
        wordListView.tableView.dataSource = self
        wordListView.playButton.addTarget(self, action: #selector(playWord), for: .touchUpInside)
    }
    
    @objc func addWord() {
        let createWordsController = CreateWordsController()
        createWordsController.setCreateWord(wordBookId: UUID(), wordBookName: "TEST")
        navigationController?.pushViewController(createWordsController, animated: true)
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
        cell.memorizeLabel.text = word.isMemorized ? "암기" : "미암기"
        cell.memorizeLabel.textColor = word.isMemorized ? UIColor.green : UIColor.red
        
        return cell
    }
}

#Preview("WordListViewController") {
WordListViewController()
}


// 화면 UI구성먼저
// 플레이버튼이 테이블뷰 위로 올라와야함..
// 저장된 데이터 불러와야하고 새로 생긴 데이터로 테이블뷰 업데이트
// viewWillAppear


