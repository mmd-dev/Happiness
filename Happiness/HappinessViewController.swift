//
//  HappinessViewController.swift
//  Happiness
//
//  Created by yanyin on 05/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    var happiness: Int = 25 { //0 = very sad, 100 = estatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
        
    }
    
    private struct Constant {
        static let HappinessGestureScale: CGFloat = 4
    }
    
//    func changeHappiness(gesture: UIPanGestureRecognizer)  {
//        switch gesture.state {
//        case .ended: fallthrough
//        case .changed:
//            let translation = gesture.translation(in: faceView)
//            let happinessChange = -Int(translation.y / Constant.HappinessGestureScale)
//            if happinessChange != 0 {
//                happiness += happinessChange
//                gesture.setTranslation(CGPoint.zero, in: faceView)
//            }
//        default: break
//        }
//    }

    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended: fallthrough
        case .changed:
            let translation = gesture.translation(in: faceView)
            let happinessChange = -Int(translation.y / Constant.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPoint.zero, in: faceView)
            }
        default: break
        }

    }
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSouce = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.scale(gesture:))))
            // 为什么这里target用faceView，为什么scale不能写在controller里面然后self.cale
            
            // target 可以是self，也可以是faceView
            
            // (1) 这边用faceView是因为FaceView 里面实现了scale(gesture:)方法
            
            // (2) 假如这边的target 是self，那么，后面的action应该这么写 #selector(self.scale(gesture:))
            //     然后在HappinessViewController里面实现 scale(gesture: UIPinchGestureRecognizer) 方法
            
            // ** 扩展，甚至这边可以用一个别的实例来做target，有兴趣可以问我，但是比较超纲，可以留在以后问
            
//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.changeHappiness(gesture:))))
            //为什么这里target用self
            
            // 这边用self 是因为happiness 这个变量存储于HappinessViewController
            //
            // 当然也可以用faceView做target，都可以，但是超纲，可以留在以后问
        }
    
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }

}
