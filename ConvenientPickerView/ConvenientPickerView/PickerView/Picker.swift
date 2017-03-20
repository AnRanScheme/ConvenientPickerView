//
//  Picker.swift
//  ConvenientPickerView
//
//  Created by 安然 on 17/3/20.
//  Copyright © 2017年 安然. All rights reserved.
//

import UIKit

struct AssociatedDataModel {
    var key: String
    var valueArray: [String]?
    init(key: String, valueArray: [String]? = nil) {
        self.key        = key
        self.valueArray = valueArray
    }
}

class Picker: UIView {

    let screenWidth  = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    // 使用模型初始化数据示例
    let associatedData: [[AssociatedDataModel]] = [
        // 第一列数据 (key)
        [   AssociatedDataModel(key: "交通工具"),
            AssociatedDataModel(key: "食品"),
            AssociatedDataModel(key: "游戏")
            
        ],
        // 第二列数据 (valueArray)
        [    AssociatedDataModel(key: "交通工具", valueArray: ["陆地", "空中", "水上"]),
             AssociatedDataModel(key: "食品", valueArray: ["健康食品", "垃圾食品"]),
             AssociatedDataModel(key: "游戏", valueArray: ["益智游戏", "角色游戏"]),
             
             ],
        
        // 第三列数据 (valueArray)
        [   AssociatedDataModel(key: "陆地", valueArray: ["公交车", "小轿车", "自行车"]),
            AssociatedDataModel(key: "空中", valueArray: ["飞机"]),
            AssociatedDataModel(key: "水上", valueArray: ["轮船"]),
            AssociatedDataModel(key: "健康食品", valueArray: ["蔬菜", "水果"]),
            AssociatedDataModel(key: "垃圾食品", valueArray: ["辣条", "不健康小吃"]),
            AssociatedDataModel(key: "益智游戏", valueArray: ["消消乐", "消灭星星"]),
            AssociatedDataModel(key: "角色游戏", valueArray: ["lol", "cf"])
            
        ]
        
    ]

    enum PickerStyles {
        case Single
        case Multiple
        case MultipleAssociated
    }
    
    var pickerStyle: PickerStyles = .Single
    
    // 完成按钮的响应Closure
    typealias ButtonAction = () -> ()
    typealias SingleCompleteAction = (_ selectedIndex: Int, _ selectedValue: String) -> ()
    typealias MultipleCompleteAction = (_ selectedIndexs: [Int], _ selectedValues: [String]) -> ()
    
    private var cancelAction: ButtonAction? {
        didSet {
            tool.cancelAction = cancelAction
        }
    }
    
    // MARK: - 只有一列的时候用到的属性
    private var singleCompleteOnClick: SingleCompleteAction? {
        didSet {
            tool.completeAction = {[unowned self] in
                self.singleCompleteOnClick?(self.selectedIndex, self.selectedValue)
            }
        }
    }
    
    private var defaultSelectedIndex: Int? {
        didSet {

}
    }
    
    
    
    
    private var singleColData: [String]?
    
    private var selectedIndex: Int = 0
    private var selectedValue: String = ""
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    


    
    
    private lazy var tool: ToolBarView = ToolBarView()
}
