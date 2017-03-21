//
//  ViewController.swift
//  ConvenientPickerView
//
//  Created by 安然 on 17/3/20.
//  Copyright © 2017年 安然. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /*
        var headquarters = Information(phoneNum: "123", address: "123 dizhi ")
        var ray = Person(name: "Ray", infomation: headquarters)
        print("ray------------\(ray.information.phoneNum)")
        var brain = Person(name: "brain", infomation: headquarters)
        print("brain------------\(brain.information.phoneNum)")
        
        brain.information.phoneNum = "789"
        print("ray.information.phoneNum------------\(ray.information.phoneNum)")
        print("brain.information.phoneNum------------\(brain.information.phoneNum)")
       */
        let str = "如果你喜欢这个控件希望你给个星星还有,本控件大量的参考了 jasnig 大神的demo,哈哈哈我就是不要脸"
        let range = (str as NSString).range(of: "本控件大量的参考了 jasnig 大神的demo")
        let attributeString = NSMutableAttributedString(string:str)
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red,range: range)
        contentLabel.attributedText = attributeString
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

/// 测试类
class Information {
    
    var phoneNum: String
    
    var address: String
    
    init(phoneNum: String, address: String) {
        self.phoneNum = phoneNum
        self.address = address
    }
}


/// 测试类
class Person {
    var name: String
    var information: Information
    
    init(name: String, infomation: Information) {
        self.name = name
        self.information = infomation
    }
}
