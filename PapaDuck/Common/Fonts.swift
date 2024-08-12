//
//  Fonts.swift
//  PapaDuck
//
//  Created by 전성진 on 8/12/24.
//

import UIKit

struct Font {
    let name: String
    let size: CGFloat
    
    func font() -> UIFont? {
        return UIFont(name: name, size: size)
    }
}

struct FontNames {
    static let mainFont: Font = Font(name: "ChangwonDangamAsac-Bold", size: 25.0)
    static let mainFont2: Font = Font(name: "ChangwonDangamAsac-Bold", size: 20.0)
    
    static let main2Font: Font = Font(name: "PeoplefirstNeat&Loud", size: 20.0)
    static let main2Font2: Font = Font(name: "PeoplefirstNeat&Loud", size: 16.0)
    static let main2Font3: Font = Font(name: "PeoplefirstNeat&Loud", size: 14.0)
    
    static let subFont: Font = Font(name: "LINESeedSansKR-Bold", size: 30.0)
    static let subFont2: Font = Font(name: "LINESeedSansKR-Bold", size: 20.0)
    static let subFont3: Font = Font(name: "LINESeedSansKR-Bold", size: 18.0)
    static let subFont4: Font = Font(name: "LINESeedSansKR-Bold", size: 16.0)
    
    static let thinFont: Font = Font(name: "LINESeedSansKR-Regular", size: 10.0)
    static let thinFont2: Font = Font(name: "LINESeedSansKR-Regular", size: 15.0)
    static let thinFont3: Font = Font(name: "LINESeedSansKR-Regular", size: 20.0)
    
    
    
    static func allFonts() -> [(font: UIFont?, name: String, size: CGFloat)] {
        return [
            (mainFont.font(), mainFont.name, mainFont.size),
            (main2Font.font(), main2Font.name, main2Font.size),
            (subFont.font(), subFont.name, subFont.size),
            (thinFont.font(), thinFont.name, thinFont.size)
        ]
    }
}
