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
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.dataSouce = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.scale(gesture:))))
                //"scale:"))
        }
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }

}
