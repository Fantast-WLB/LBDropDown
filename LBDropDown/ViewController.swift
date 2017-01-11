//
//  ViewController.swift
//  LBDropDown
//
//  Created by BO'S MINI on 17/1/3.
//  Copyright © 2017年 whatTheGhost. All rights reserved.
//

import UIKit

class ViewController: UIViewController,LBDropDownDelegate {
    
    var dropDown:LBDropDown?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func dropDownClicked(_ sender: UIButton) {
        
        
        if (self.dropDown != nil)
        {
            self.dropDown!.hideDropDown(BasicView: sender)
            self.dropDown = nil
            return
        }
        self.dropDown = LBDropDown.init()
        let num = arc4random_uniform(4)
        var direction:Direction?
        switch num {
        case 0:
            direction = Direction.Up
        case 1:
            direction = Direction.Down
        case 2:
            direction = Direction.Left
        default:
            direction = Direction.Right
        }
        self.dropDown!.showDropDown(BasicButton: sender, ViewDirection:direction!, ViewHeight: 100, TitleArray: ["我是第一个","我是第二个","我是第三个","我是第四个"], ImageArray: [])
        self.dropDown!.delegate = self
    }

    func choseTheCell(DropDown dropDown: LBDropDown) {
        self.dropDown = nil
    }
}

