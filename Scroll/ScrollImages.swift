//
//  ScrollImages.swift
//  ScrollImages
//
//  Created by YuanGu on 2018/1/18.
//  Copyright © 2018年 YuanGu. All rights reserved.
//

import UIKit

class ScrollImages: UIView {

    var autoScroll: Bool = false //是否自动滑动
    var selectIndex: NSInteger = 0 //默认选中 作为扩展使用的
    var delegate: ScrollImagesProtocol? //声明代理
    
    private var images: [UIImage]!
    private var timer: Timer?
    private var scrollView: UIScrollView?
    private var leftView: UIImageView?
    private var centerView: UIImageView?
    private var rightView: UIImageView?
    private var leftIndex: NSInteger = 0
    private var rightIndex: NSInteger = 0
    private var currentIndex: NSInteger = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpScrollView()
        setUpImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: public
    public func setImages(image: [UIImage]) {
        images = image
        
        reloadImages()
        
        if autoScroll {
            
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
            
            timer = Timer(timeInterval: 1, repeats: true, block: { (timers) in
                self.autoScrollAction()
            })
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    public func setAutoScoll(auto: Bool) {
        autoScroll = auto
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        if autoScroll {
            timer = Timer(timeInterval: 1, repeats: true, block: { (timers) in
                self.autoScrollAction()
            })
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    // MARK: UI
    func setUpScrollView() {
        
        scrollView = UIScrollView.init(frame: self.bounds)
        scrollView?.delegate = self;
        scrollView?.isPagingEnabled = true
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.bounces = false
        scrollView?.contentSize = CGSize.init(width: self.width*3, height: self.height)
        
        self.addSubview(scrollView!)
        
        scrollView?.setContentOffset(CGPoint.init(x: self.width, y: 0), animated: false)
    }
    
    func setUpImageView() {
        
        leftView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
        rightView = UIImageView(frame: CGRect.init(x: self.width*2, y: 0, width: self.width, height: self.height))
        centerView = UIImageView(frame: CGRect.init(x: self.width, y: 0, width: self.width, height: self.height))
        
        scrollView?.addSubview(leftView!)
        scrollView?.addSubview(centerView!)
        scrollView?.addSubview(rightView!)
        
        centerView?.isUserInteractionEnabled = true
        centerView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:#selector(centerViewTap(tap:)) ))
    }
    
    // MARK: Action
    @objc func centerViewTap(tap: UIGestureRecognizer) {
        delegate?.ScrollImagesClick!(index: currentIndex)
    }
    
    func reloadImages() {
        
        let origin = scrollView?.contentOffset.x
        
        //滑动到最后位置
        if origin == (scrollView?.width)!*2 {
            if currentIndex == images.count-1 {
                currentIndex = 0
            }else{
                currentIndex += 1
            }
        }else if origin == 0{
            if currentIndex == 0 {
                currentIndex = images.count-1
            }else{
                currentIndex -= 1
            }
        }
        
        reloadIndex()
        
        leftView?.image = images[leftIndex]
        centerView?.image = images[currentIndex]
        rightView?.image = images[rightIndex]
    }
    
    func reloadIndex(){
        
        if currentIndex == 0 {
            leftIndex = images.count-1
        }else{
            leftIndex = currentIndex-1
        }
        
        if currentIndex == images.count-1 {
            rightIndex = 0
        }else{
            rightIndex = currentIndex+1
        }
    }
    
    func autoScrollAction() {
        
        var currentPoint: CGPoint = (scrollView?.contentOffset)!
        
        currentPoint.x += (scrollView?.width)!
        
        scrollView?.setContentOffset(currentPoint, animated: true)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension ScrollImages: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoScroll {
            timer = Timer(timeInterval: 1, repeats: true, block: { (timers) in
                self.autoScrollAction()
            })
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        reloadImages()
        scrollView.setContentOffset(CGPoint.init(x: scrollView.width, y: 0), animated: false)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImages()
        scrollView.setContentOffset(CGPoint.init(x: scrollView.width, y: 0), animated: false)
    }
}

@objc protocol ScrollImagesProtocol {
    /**
     *  选中的下标 回调
     */
    @objc optional func ScrollImagesClick(index: NSInteger)
}
