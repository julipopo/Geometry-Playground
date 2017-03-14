//
//  GridView.swift
//  testLayer
//
//  Created by Julien Simmer  on 02/03/2017.
//  Copyright © 2017 Julien Simmer. All rights reserved.
//

import UIKit

class GridView: UIView, UIScrollViewDelegate {
    //La gridView(0) doit etre collée en tout bord dans une scrollView(1).Elle(1) meme collée en tout bord à une vue supérieur(2) (exemple la vue principale du view controller). On choisit ensuite une longueur et largeur (de préférence égales, soit un carré) pour la gridview(0), et on delegate la scrollview(1) vers la gridview(0).
    
    var epaisseurLigne = 1
    var couleurLigne = UIColor.lightGray
    var verticalLignes:[UIView] = []
    var horizontalLignes:[UIView] = []
    var topLabels:[UILabel] = []
    var leftLabels:[UILabel] = []
    var bottomLabels:[UILabel] = []
    var rightLabels:[UILabel] = []
    let topScrollView = UIScrollView()
    let leftScrollView = UIScrollView()
    let coinTopLeft = UIView()
    let bouttonToStart = UIButton()
    
    // MARK:
    func applyGrid() {
        setLines()
        setRegles()
        setTopLeftCorner()
        setBouttonToStart()
    }
    
    //MARK:
    func setLines(){
        let kWidth = Int(self.frame.width)
        let kHeight = Int(self.frame.height)
        
        //Vertical
        for i in 1...kWidth/100-1 {
            
            let verticalLigne = UIView()
            
            verticalLigne.frame = CGRect(x: i*100, y: 0, width: epaisseurLigne, height: kHeight)
            verticalLigne.backgroundColor = couleurLigne
            
            verticalLignes.append(verticalLigne)
            self.addSubview(verticalLigne)
        }
        
        //Horizontal
        for i in 1...Int(kHeight/100)-1 {
            
            let horizontalLigne = UIView()
            
            horizontalLigne.frame = CGRect(x: 0, y: i*100, width: kWidth, height: epaisseurLigne)
            horizontalLigne.backgroundColor = couleurLigne
            
            horizontalLignes.append(horizontalLigne)
            self.addSubview(horizontalLigne)
        }
    }
    
    func setRegles(){
        let kWidth = Int(self.frame.width)
        let kHeight = Int(self.frame.height)
        let SUPER = self.superview?.superview
        
        topScrollView.frame = CGRect(x: 30, y: 0, width: (SUPER?.frame.width)!, height: 20)
        topScrollView.contentSize = CGSize(width: kWidth, height: 30)
        topScrollView.backgroundColor = UIColor.white
        topScrollView.isScrollEnabled = false
        SUPER?.addSubview(topScrollView)
        
        for i in 1...kWidth/100-1 {
            
            let topLabel = UILabel()
            
            topLabel.frame = CGRect(x: i*100-15-30, y: 0, width: 30, height: 20)
            topLabel.text = ("\(i*100)")
            setLabel(label: topLabel)
            
            topLabels.append(topLabel)
            topScrollView.addSubview(topLabel)
        }
        
        leftScrollView.frame = CGRect(x: 0, y: 20, width: 30, height: (SUPER?.frame.height)!)
        leftScrollView.contentSize = CGSize(width: 30, height: kHeight)
        leftScrollView.backgroundColor = UIColor.white
        leftScrollView.isScrollEnabled = false
        SUPER?.addSubview(leftScrollView)
        
        for i in 1...Int(kHeight/100)-1 {
            
            let leftLabel = UILabel()
            
            leftLabel.frame = CGRect(x: 1, y: i*100-10-20, width: 30, height: 20)
            leftLabel.text = ("\(i*100)")
            setLabel(label: leftLabel)
            
            leftLabels.append(leftLabel)
            leftScrollView.addSubview(leftLabel)
        }
    }
    
    func setTopLeftCorner(){
        let SUPER = self.superview?.superview
        coinTopLeft.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        coinTopLeft.backgroundColor = UIColor.white
        SUPER?.addSubview(coinTopLeft)
    }
    
    func setBouttonToStart(){
        let SUPER = self.superview?.superview
        bouttonToStart.frame = CGRect(x: (SUPER?.frame.width)!-70, y: (SUPER?.frame.height)!-70, width: 50, height: 50)
        bouttonToStart.isEnabled = false
        bouttonToStart.addTarget(self, action: #selector(toStartAction), for: .touchUpInside)
        bouttonToStart.alpha = 0
        bouttonToStart.setImage(UIImage(named: "arrowBackToStart"), for: .normal)
        SUPER?.addSubview(bouttonToStart)
    }
    
    func setLabel(label : UILabel){
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 10)
    }
    
    //MARK:
    func toStartAction(sender: UIButton!) {
        let superScrollView = self.superview as! UIScrollView
        superScrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 100, height: 100), animated: true)
        self.topScrollView.contentOffset = CGPoint(x: 0, y:0)
        self.leftScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let superScrollView = self.superview as! UIScrollView
        let xx = superScrollView.contentOffset.x
        let yy = superScrollView.contentOffset.y
        self.topScrollView.contentOffset = CGPoint(x: xx, y:0)
        self.leftScrollView.contentOffset = CGPoint(x: 0, y: yy)
        if xx > 1200 || yy > 1200 {
            rotateButton(x: xx, y: yy)
            showBoutton()
        }
        else if xx < 200 && yy < 200 {
            hideBoutton()
        }else{
            rotateButton(x: xx, y: yy)
            let tint1 = (xx-200)/1000
            let tint2 = (yy-200)/1000
            let tint3 = tint1 > tint2 ? tint1 : tint2
            tintBoutton(tint: tint3)
        }
        
    }
    
    func rotateButton(x:CGFloat, y:CGFloat){
        var angle:CGFloat = 315
        if x<y{
            angle = 360-(45*x/y)
        }
        if x>y{
            angle = 270+(45*y/x)
        }
        bouttonToStart.transform = CGAffineTransform(rotationAngle: angle*CGFloat(M_PI)/180)
        
    }
    
    func hideBoutton(){
        bouttonToStart.alpha = 0
        bouttonToStart.isEnabled = false
    }
    func tintBoutton(tint:CGFloat){
        bouttonToStart.alpha = tint
        bouttonToStart.isEnabled = true
    }
    func showBoutton(){
        bouttonToStart.alpha = 1
        bouttonToStart.isEnabled = true
    }
}
