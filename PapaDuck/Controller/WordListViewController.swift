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
    
    var words: [WordsEntity] = []
    
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    
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
        
        // 버튼들 액션 설정
        wordListView.playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        wordListView.allwordPlayButton.addTarget(self, action: #selector(playAllWord), for: .touchUpInside)
        wordListView.unmemorizedPlayButton.addTarget(self, action: #selector(playUnmemorizedWord), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isActive = false
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
    
    // 버튼 클릭
    @objc private func didTapPlayButton() {
        isActive.toggle()
    }
    
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        let buttons = [wordListView.allwordPlayButton, wordListView.unmemorizedPlayButton]
        
        for (index, button) in buttons.enumerated() {
            if isActive {
                button.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
                UIView.animate(withDuration: 0.3, delay: 0.1 * Double(index), usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: {
                    button.layer.transform = CATransform3DIdentity
                    button.alpha = 1.0
                })
            } else {
                UIView.animate(withDuration: 0.15, delay: 0.1 * Double(index), options: []) {
                    button.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                    button.alpha = 0.0
                }
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        wordListView.playButton.layer.add(animation, forKey: nil)
    }
    
    // AllwordPlayButton 클릭 시 호출되는 메서드
    @objc func playAllWord() {
        if let book = selectedBook, let id = book.wordsBookId {
            let memorizeController = MemorizeController()
            memorizeController.wordsBookId = id
            navigationController?.pushViewController(memorizeController, animated: true)
        }
    }
    
    // unmemorizedPlayButton 클릭 시 호출되는 메서드
    @objc func playUnmemorizedWord() {
        if let book = selectedBook, let id = book.wordsBookId {
            let memorizeController = MemorizeController()
            memorizeController.wordsBookId = id
            memorizeController.mode = .unmemorizedWords
            navigationController?.pushViewController(memorizeController, animated: true)
        }
    }
    
//    @objc func playWord() {
//        // 단어장 플레이 화면
//        if let book = selectedBook, let id = book.wordsBookId {
//            let memorizeController = MemorizeController()
//            memorizeController.wordsBookId = id
//            navigationController?.pushViewController(memorizeController, animated: true)
//        }
//    }
    
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
        cell.memorizeLabel.textColor = word.memorizationYn ? UIColor.subBlue3 : UIColor.subRed
        
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


