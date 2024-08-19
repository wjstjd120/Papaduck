//
//  MypageView.swift
//  PapaDuck
//
//  Created by 신상규 on 8/13/24.
//

import UIKit
import SnapKit

class MypageView: UIView {
    
    private let headLabel: UILabel = {
        let label = UILabel()
        label.text = "머리심기"
        label.font = FontNames.mainFont.font()
        label.textColor = .black
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "파파덕"
        label.font = FontNames.subFont.font()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    public var lvLabel: UILabel = {
        let label = UILabel()
        label.text = "Lv.1"
        label.font = FontNames.thinFont3.font()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    public var exLabel: UILabel = {
        let label = UILabel()
        label.text = "0/100" //초기값을 0으로 설정
        label.font = FontNames.main2Font2.font()
        label.textColor = .black
        return label
    }()
    
    public var lvImage: UIImageView = {
        var image = UIImageView()
        image.image = .lv1
        image.frame = .init(x: 0, y: 0, width: 20, height: 20)
        return image
    }()
    
    public var userStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .bottom
        return stackView
    }()
    
    public let exProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0
        progressView.progressViewStyle = .bar
        progressView.center = .zero
        progressView.frame = CGRect(x: 0, y: 0, width: 300, height: 20)
        progressView.trackTintColor = UIColor.lightGray // 배경 트랙 색상
        progressView.progressTintColor = UIColor.subBlue // 진행되는 바 색상
        return progressView
    }()
    
    public var calendarView: UICalendarView = {
        var calendarView = UICalendarView()
        //기본값은 true
        calendarView.wantsDateDecorations = true
        //한국어로 표현
        calendarView.locale = Locale(identifier: "ko_KR")
        return calendarView
    }()
    
    //등록된 단어 갯수
    public var registrationnumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = FontNames.main2Font.font()
        label.textColor = .black
        return label
    }()
    
    //암기단어 갯수
    public var memorizingnumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = FontNames.main2Font.font()
        label.textColor = .black
        return label
    }()
    
    private let registrationText: UILabel = {
        let label = UILabel()
        label.text = "등록 단어 갯수"
        label.font = FontNames.main2Font.font()
        label.textColor = .black
        return label
    }()
    
    private var memorizingText: UILabel = {
        let label = UILabel()
        label.text = "암기 단어 갯수"
        label.font = FontNames.main2Font.font()
        label.textColor = .black
        return label
    }()
    
    private var registrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private var memorizingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()
    
    private var layOutStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .mainYellow
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mypageLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func mypageLayout() {
        [headLabel, userStackView, exProgressView, calendarView, layOutStackView].forEach { addSubview($0) }
        [nameLabel, lvLabel, exLabel, lvImage].forEach { userStackView.addArrangedSubview($0) }
        [registrationnumber, registrationText].forEach { registrationStackView.addArrangedSubview($0) }
        [memorizingnumber, memorizingText].forEach { memorizingStackView.addArrangedSubview($0) }
        [registrationStackView, memorizingStackView].forEach { layOutStackView.addArrangedSubview($0) }
        
        // 헤더뷰 레이아웃
        headLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(60)
        }
        
        userStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(headLabel.snp.bottom)
            $0.width.equalTo(320) // 최대 너비 설정
            $0.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(100) // 최대 너비 설정
        }
        
        lvLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(50) // 최대 너비 설정
        }
        
        exLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(60) // 최대 너비 설정
        }
        
        lvImage.snp.makeConstraints {
            $0.width.height.equalTo(95)
        }
        
        exProgressView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userStackView.snp.bottom).offset(20)
            $0.width.equalTo(320)
            $0.height.equalTo(10)
        }
        
        layOutStackView.snp.makeConstraints {
            $0.top.equalTo(exProgressView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(80)
        }
        
        calendarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(layOutStackView.snp.bottom)
            $0.width.equalTo(320)
            $0.height.equalTo(450)
        }
    }
}

