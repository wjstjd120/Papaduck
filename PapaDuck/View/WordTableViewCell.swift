//
//  WordTableViewCell.swift
//  PapaDuck
//
//  Created by 내꺼다 on 8/13/24.
//

import UIKit
import SnapKit

class WordTableViewCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 255/255, green: 254/255, blue: 242/255, alpha: 1.0)
        
        return view
    }()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = FontNames.main2Font2.font()
        return label
    }()
    
    let meaningLabel: UILabel = {
        let label = UILabel()
        label.font = FontNames.main2Font2.font()
        return label
    }()
    
    let memorizeLabel: UILabel = {
        let label = UILabel()
        label.font = FontNames.main2Font2.font()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [containerView, wordLabel, meaningLabel, memorizeLabel].forEach {
            contentView.addSubview($0)
        }
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        wordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalTo(containerView.snp.top)
            $0.width.height.equalTo(60)
        }
        
        meaningLabel.snp.makeConstraints {
            $0.top.equalTo(wordLabel.snp.bottom).inset(10)
            $0.leading.equalTo(wordLabel.snp.leading)
            $0.width.equalTo(100)
        }
        
        memorizeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(meaningLabel.snp.centerY)
        }
    }
    
}
