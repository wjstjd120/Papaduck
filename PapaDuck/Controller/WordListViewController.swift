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
        // 단어 추가 화면
    }
    
    @objc func playWord() {
        // 단어장 플레이 화면
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 수정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        cell.textLabel?.text = "예제 단어 \(indexPath.row + 1)" // 예제 데이터, 실제 데이터로 변경 필요
        return cell
    }
}



// 화면 UI구성먼저
// 플레이버튼이 테이블뷰 위로 올라와야함..
// 저장된 데이터 불러와야하고 새로 생긴 데이터로 테이블뷰 업데이트
// viewWillAppear


