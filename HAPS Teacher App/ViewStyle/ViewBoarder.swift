//
//  ViewBoarder.swift
//  HAPS Teacher App
//
//  Created by Raj Mohan on 27/07/23.
//

import Foundation
import UIKit


class ViewBorder: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderColor = UIColor(red: 0, green: 0.6, blue: 0.93, alpha: 1).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
}

class ProfileViewBorder: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderColor = UIColor(red: 0.865, green: 0.865, blue: 0.865, alpha: 1).cgColor
        layer.borderWidth = 1
    }
}
class ViewBorderGreen: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderColor = UIColor(red: 0.816, green: 0.961, blue: 0.813, alpha: 1).cgColor
        layer.borderWidth = 1
    }
}
class CircularView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderColor = UIColor.white.cgColor
        //clipsToBounds = true
    }
}
@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
class ShadowView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 10
        layer.cornerRadius = 12
    }
}
class ShadowBorder: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 10
    }
}

