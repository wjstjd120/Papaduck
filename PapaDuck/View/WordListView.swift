//
//  WordListView.swift
//  PapaDuck
//
//  Created by 내꺼다 on 8/13/24.
//

import UIKit
import SnapKit

class WordListView: UIView {
    
    let tableView = UITableView()
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶︎", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupPlayButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
        setupPlayButton()
    }
    
    private func setupTableView() {
        tableView.rowHeight = 100
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: "WordCell")
        tableView.separatorStyle = .none
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupPlayButton() {
        addSubview(playButton)
        
        playButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
