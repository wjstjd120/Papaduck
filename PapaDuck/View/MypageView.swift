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
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "유저"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    public var lvLabel: UILabel = {
        let label = UILabel()
        label.text = "Lv.1"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    public var exLabel: UILabel = {
        let label = UILabel()
        label.text = "90/100" //초기값을 0으로 설정
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    public var lvImage: UIImageView = {
        var image = UIImageView()
        image.image = .lv1
        image.frame = .init(x: 0, y: 0, width: 20, height: 20)
        return image
    }()
    
    public var userStackVeiw: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
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
    private var registrationnumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    //암기단어 갯수
    private var memorizingnumber: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    private let registrationText: UILabel = {
        let label = UILabel()
        label.text = "등록 단어 갯수"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private var memorizingText: UILabel = {
        let label = UILabel()
        label.text = "암기 단어 갯수"
        label.font = .boldSystemFont(ofSize: 20)
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
        [headLabel, userStackVeiw, exProgressView, calendarView, registrationStackView, memorizingStackView, layOutStackView].forEach { self.addSubview($0) } // 마이페이지 , 스텍뷰
        [nameLabel, lvLabel, exLabel, lvImage].forEach { userStackVeiw.addArrangedSubview($0) } // 스텍뷰 안에 집어넣음
        [registrationnumber, registrationText].forEach { registrationStackView.addArrangedSubview($0) } // 등록된 단어 갯수
        [memorizingnumber, memorizingText].forEach { memorizingStackView.addArrangedSubview($0) } // 등록 암기 갯수
        [registrationStackView, memorizingStackView].forEach{ layOutStackView.addArrangedSubview($0) } // 단어, 암기 스택뷰
        
        //헤더뷰 레이아웃
        headLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(80)
        }
        
        userStackVeiw.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(100)
            $0.top.equalTo(headLabel.snp.bottom).offset(20)
        }
        
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(userStackVeiw.snp.leading).offset(10)
        }
        
        lvLabel.snp.makeConstraints{
            $0.leading.equalTo(userStackVeiw.snp.leading).offset(70)
        }
        
        exLabel.snp.makeConstraints{
            $0.leading.equalTo(userStackVeiw.snp.leading).offset(160)
        }
        
        //레벨별 이미지
        lvImage.snp.makeConstraints{
            $0.width.height.equalTo(95)
        }
        
        exProgressView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userStackVeiw.snp.bottom).offset(20)
            $0.width.equalTo(320)
            $0.height.equalTo(10)
        }
        
        layOutStackView.snp.makeConstraints{
            $0.top.equalTo(exProgressView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(100)
        }
        
        calendarView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(layOutStackView.snp.bottom).offset(10)
            $0.width.equalTo(320)
            $0.height.equalTo(450)
        }
    }
}

