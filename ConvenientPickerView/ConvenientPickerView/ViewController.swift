//
//  ViewController.swift
//  ConvenientPickerView
//
//  Created by 安然 on 17/3/20.
//  Copyright © 2017年 安然. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        var headquarters = Information(phoneNum: "123", address: "123 dizhi ")
        var ray = Person(name: "Ray", infomation: headquarters)
        print("ray------------\(ray.information.phoneNum)")
        var brain = Person(name: "brain", infomation: headquarters)
        print("brain------------\(brain.information.phoneNum)")
        
        brain.information.phoneNum = "789"
        print("ray.information.phoneNum------------\(ray.information.phoneNum)")
        print("brain.information.phoneNum------------\(brain.information.phoneNum)")
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Information {
    
    var phoneNum: String
    
    var address: String
    
    init(phoneNum: String, address: String) {
        self.phoneNum = phoneNum
        self.address = address
    }
}


class Person {
    var name: String
    var information: Information
    
    init(name: String, infomation: Information) {
        self.name = name
        self.information = infomation
    }
}
