//
//  ViewController.swift
//  ScrollImages
//
//  Created by YuanGu on 2018/1/18.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images: [UIImage] = [UIImage(named: "1")!,
                                 UIImage(named: "2")!,
                                 UIImage(named: "3")!,
                                 UIImage(named: "4")!,
                                 UIImage(named: "5")!]
        
        let scroll = ScrollImages(frame: CGRect(x: 0,
                                                y: self.view.height/4,
                                                width: self.view.width,
                                                height: self.view.height/2))
        
        scroll.delegate = self
        scroll.autoScroll = true
        self.view.addSubview(scroll)
        
        scroll.setImages(image: images)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(integerLiteral: 5)) {
            scroll.setAutoScoll(auto: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}
extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}


extension ViewController: ScrollImagesProtocol {
    
    func ScrollImagesClick(index: NSInteger) {
        print("点击: \(index)")
    }
}
