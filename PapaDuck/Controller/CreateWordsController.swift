//
//  CreateWordsController.swift
//  PapaDuck
//
//  Created by 백시훈 on 8/13/24.
//

import Foundation
import UIKit
class CreateWordsController: UIViewController{
    let createWordsView = CreateWordsView()
    override func loadView() {
        view = createWordsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
