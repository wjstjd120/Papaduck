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

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupMainView()
        addTapGestureToLabel()
        view = mainView
    }

//    private func setupMainView() {
//        view.addSubview(mainView)
//        
//        mainView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
    
    private func addTapGestureToLabel() { 
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
           mainView.addLabel.addGestureRecognizer(tapGesture)
       }

       @objc private func handleLabelTap() {
           print("라벨이 터치되었습니다!")
           let CreateWordsController = CreateWordsController()
           navigationController?.pushViewController(CreateWordsController, animated: true)
       }
    
}
