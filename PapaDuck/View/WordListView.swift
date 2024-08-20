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
        button.backgroundColor = .subBlue2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    let allwordPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("All", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.subBlue3
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.alpha = 0.0  // 처음에는 보이지 않도록 설정
        return button
    }()
    
    let unmemorizedPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("미암기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.subRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.alpha = 0.0  // 처음에는 보이지 않도록 설정
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupPlayButton()
        setupAdditionalButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
        setupPlayButton()
        setupAdditionalButtons()
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
    
    private func setupAdditionalButtons() {
        addSubview(allwordPlayButton)
        addSubview(unmemorizedPlayButton)
        
        // writeButton 위치 설정 (playButton 위로)
        allwordPlayButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(playButton.snp.top).offset(-20)
        }
        
        // secondButton 위치 설정 (writeButton 위로)
        unmemorizedPlayButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(allwordPlayButton.snp.top).offset(-20)
        }
    }
}
