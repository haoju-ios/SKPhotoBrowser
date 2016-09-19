//
//  SKBottomToolbar.swift
//  SKPhotoBrowser
//
//  Created by wangyao@lifang.com on 16/9/19.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import UIKit

private let bundle = Bundle(for: SKPhotoBrowser.self)

class SKBottomToolbar: UIToolbar {
    var bottomToolCenterButton: UIBarButtonItem!
    var bottomToolRightButton: UIBarButtonItem!
    
    fileprivate weak var browser: SKPhotoBrowser?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, browser: SKPhotoBrowser) {
        self.init(frame: frame)
        self.browser = browser
        
        setupApperance()
        setupCenterButton()
        setupRightButton()
        setupToolbar()
    }
}

private extension SKBottomToolbar {
    func setupApperance() {
        backgroundColor = .clear
        clipsToBounds = true
        isTranslucent = true
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        
        // toolbar
        if !SKPhotoBrowserOptions.displayBottomToolbar {
            isHidden = true
        }
    }
    
    func setupToolbar() {
        guard browser != nil else { return }
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(bottomToolCenterButton)
        items.append(flexSpace)
        items.append(bottomToolRightButton)
        setItems(items, animated: false)
    }
    
    func setupCenterButton() {
        let centerButton = SKCenterButton(frame: frame)
        centerButton.addTarget(browser, action: #selector(SKPhotoBrowser.saveImagesToPhotoAlbum), for: .touchUpInside)
        bottomToolCenterButton = UIBarButtonItem(customView: centerButton)
    }
    
    func setupRightButton() {
        let rightButton = SKNextButton(frame: frame)
        rightButton.addTarget(browser, action: #selector(SKPhotoBrowser.handleCustomAction), for: .touchUpInside)
        bottomToolRightButton = UIBarButtonItem(customView: rightButton)
    }
    
}


class SKCenterButton: SKToolbarButton {
    let imageName = "btn_common_download"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        setup(imageName)
    }
}

class SKRightButton: SKToolbarButton {
    let imageName = "btn_common_report"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        setup(imageName)
    }
}
