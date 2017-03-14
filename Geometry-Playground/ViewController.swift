//
//  ViewController.swift
//  Geometry-Playground
//
//  Created by Julien Simmer on 14/03/2017.
//  Copyright © 2017 julipopo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var viewForTest: UIView!
    @IBOutlet weak var gridView: GridView!
    
    let testLayer2 = CAShapeLayer()
    let aPath = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gridView.applyGrid()

        aPath.move(to: CGPoint(x: 100, y: 0))
        aPath.addLine(to: CGPoint(x: 200, y: 40))
        aPath.addLine(to: CGPoint(x: 160, y: 140))
        aPath.addLine(to: CGPoint(x: 40, y: 140))
        aPath.addLine(to: CGPoint(x: 0, y: 40))
        aPath.close()
        
        testLayer2.backgroundColor = UIColor.brown.cgColor
        testLayer2.path = aPath.cgPath
        testLayer2.fillColor = UIColor.cyan.cgColor
        testLayer2.frame = CGRect(x: 100, y: 100, width: 200, height: 140)
        self.gridView.layer.addSublayer(self.testLayer2)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func startAnimation(_ sender: Any) {
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = 2
        morphAnimation.toValue = trianglePath()
        morphAnimation.delegate = self
        morphAnimation.fillMode = kCAFillModeForwards
        morphAnimation.isRemovedOnCompletion = false
        morphAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        testLayer2.add(morphAnimation, forKey: "morphAnim")
    }

    @IBAction func resetAnimation(_ sender: Any) {
        testLayer2.removeAnimation(forKey: "morphAnim")
        testLayer2.path = aPath.cgPath
    }
    
    func trianglePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:100,y: 20))
        path.addLine(to: CGPoint(x: 130, y: 70))
        path.addLine(to: CGPoint(x: 160, y: 120))
        path.addLine(to: CGPoint(x: 40, y: 120))
        path.addLine(to: CGPoint(x: 70, y: 70))
        path.close()
        return path.cgPath
    }
    
}

