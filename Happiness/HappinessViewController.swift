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
            //为什么这里target用faceView，为什么scale不能写在controller里面然后self.cale
//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.changeHappiness(gesture:))))
            //为什么这里target用self
        }
    
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }

}
