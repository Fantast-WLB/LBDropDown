//
//  LBDropDown.swift
//  LBDropDown
//
//  Created by BO'S MINI on 17/1/3.
//  Copyright © 2017年 whatTheGhost. All rights reserved.
//

import UIKit

enum Direction:NSInteger {
    case Up     = 0
    case Down   = 1
    case Left   = 2
    case Right  = 3
}

protocol LBDropDownDelegate {
    
    func choseTheCell(DropDown dropDown:LBDropDown) -> Void
    
}

class LBDropDown: UIView,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - variety
    ///方向
    var direction:Direction?
    ///动画时间
    var animateDuration:TimeInterval?
    ///基石按钮
    var basicButton:UIButton?
    
    var listTableView:UITableView = UITableView()
    
    var delegate:LBDropDownDelegate?
    ///标题数组
    var titles:[String]?
    ///图片数组（需要与标题长度一致）
    var images:[UIImage]?
    ///行高
    var rowHeight:CGFloat?
    ///分割样式
    var separatorStyle:UITableViewCellSeparatorStyle?
    ///分割颜色
    var separatorColor:UIColor?
    ///背景颜色
    var backColor:UIColor?
    ///弹簧
    var bounce:Bool?
    ///滚动条
    var showIndicator:Bool?
    ///阴影宽度
    var shadowWidth:CGFloat?
    ///文字大小
    var textSize:CGFloat?
    
    // MARK: - constant
    let ReuseIdentifier:String = "ReuseID"
    
    let CornerRadius:CGFloat = 5
    
    let ShadowRadius:CGFloat = 3
    
    let ShadowOpacity:CGFloat = 0.3
    
    override init(frame: CGRect) {
        
        
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDropDown(BasicButton button:UIButton,ViewDirection direction:Direction,ViewHeight height:CGFloat,TitleArray titles:[String],ImageArray images:[UIImage]) -> Void {
        
        self.basicButton = button
        self.direction = direction
        self.titles = titles
        self.images = images
        
        self.listTableView = UITableView.init()
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.layer.cornerRadius = CornerRadius
        self.listTableView.separatorStyle = self.separatorStyle ?? UITableViewCellSeparatorStyle.singleLine
        self.listTableView.separatorColor = self.separatorColor
        self.listTableView.backgroundColor = self.backColor
        self.listTableView.bounces = self.bounce ?? false
        self.listTableView.showsVerticalScrollIndicator = self.showIndicator ?? false
        self.listTableView.showsHorizontalScrollIndicator = self.showIndicator ?? false

        let basicFrame = button.frame
        
        switch direction {
        case .Up:
            self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y, width: basicFrame.width, height: 0)
            self.layer.shadowOffset = CGSize(width: shadowWidth ?? 5, height: -(shadowWidth ?? 5))
        case .Down:
            self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y + basicFrame.height, width: basicFrame.width, height: 0)
            self.layer.shadowOffset = CGSize(width: shadowWidth ?? 5, height: shadowWidth ?? 5)
        case .Left:
            self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y, width: 0, height: basicFrame.height)
            self.layer.shadowOffset = CGSize(width: -(shadowWidth ?? 5), height: shadowWidth ?? 5)
        default:
            self.frame = CGRect(x: basicFrame.origin.x + basicFrame.width, y: basicFrame.origin.y, width: 0, height: basicFrame.height)
            self.layer.shadowOffset = CGSize(width: shadowWidth ?? 5, height: shadowWidth ?? 5)
        }
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = CornerRadius
        self.layer.shadowRadius = ShadowRadius
        self.layer.shadowOpacity = Float(ShadowOpacity)
        
        UIView.animate(withDuration: self.animateDuration ?? 0.25){() -> Void in
            switch direction {
            case .Up:
                self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y - height, width: basicFrame.width, height: height)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: basicFrame.width, height: height)
            case .Down:
                self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y + basicFrame.height, width: basicFrame.width, height: height)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: basicFrame.width, height: height)
            case .Left:
                self.frame = CGRect(x: basicFrame.origin.x - basicFrame.width, y: basicFrame.origin.y, width: basicFrame.width, height: height)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: basicFrame.width, height: height)
            default:
                self.frame = CGRect(x: basicFrame.origin.x + basicFrame.width, y: basicFrame.origin.y, width: basicFrame.width, height: height)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: basicFrame.width, height: height)
            }
        }

        basicButton?.superview?.addSubview(self)
        
        self.addSubview(listTableView)
    }
    
    func hideDropDown(BasicView view:UIView) -> Void {
        let basicFrame:CGRect = view.frame
        
        UIView.animate(withDuration: self.animateDuration ?? 0.25){() -> Void in
            switch self.direction! {
            case .Up:
                self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y, width: basicFrame.width, height: 0)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: basicFrame.width, height: 0)
            case .Down:
                self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y + basicFrame.height, width: basicFrame.width, height: 0)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: basicFrame.width, height: 0)
            case .Left:
                self.frame = CGRect(x: basicFrame.origin.x, y: basicFrame.origin.y, width: 0, height: basicFrame.height)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: 0, height: basicFrame.height)
            default:
                self.frame = CGRect(x: basicFrame.origin.x + basicFrame.width, y: basicFrame.origin.y, width: 0, height: basicFrame.height)
                self.listTableView.frame = CGRect(x: 0, y: 0, width: 0, height: basicFrame.height)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style:UITableViewCellStyle.default, reuseIdentifier: ReuseIdentifier)
        }
        
        cell?.textLabel?.text = titles?[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: self.textSize ?? 15)
        cell?.imageView?.image = images?.count == titles?.count ? images?[indexPath.row] : nil
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight ?? 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.basicButton?.setTitle(titles?[indexPath.row], for: UIControlState.normal)
        self.basicButton?.setImage(images?.count == titles?.count ? images?[indexPath.row] : nil, for: UIControlState.normal)
        
        if (self.delegate != nil) {
            self.delegate?.choseTheCell(DropDown: self)
        }
        
        self.hideDropDown(BasicView: self.basicButton!)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
