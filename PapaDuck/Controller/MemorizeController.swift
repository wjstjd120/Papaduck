//
//  MemorizeController.swift
//  PapaDuck
//
//  Created by 전성진 on 8/13/24.
//

import UIKit

class MemorizeController: UIViewController {
    var memorizeView: MemorizeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "단어장 외우기"
        memorizeView = MemorizeView()
        self.view = memorizeView
    }
}
