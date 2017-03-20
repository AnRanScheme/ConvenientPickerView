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
            if let defaultIndex = defaultSelectedIndex, let singleData = singleColData {
                assert(defaultIndex >= 0 && defaultIndex < singleData.count, "设置的默认选中Index不合法")
                if defaultIndex >= 0 && defaultIndex < singleData.count {
                    // 设置默认值
                    selectedIndex = defaultIndex
                    selectedValue = singleData[defaultIndex]
                    // 滚动到默认位置
                    pickerView.selectRow(defaultIndex, inComponent: 0, animated: false)
                }
            } else {
                // 没有默认值设置0行为默认值
                selectedIndex = 0
                selectedValue = singleColData![0]
                pickerView.selectRow(0, inComponent: 0, animated: false)
            }
        }
    }

    private var singleColData: [String]?
    
    private var selectedIndex: Int = 0
    private var selectedValue: String = ""
    
    // MARK: - 多列不关联的时候用到的属性
    var multipleCompleteOnClick: MultipleCompleteAction? {
        didSet {
            tool.completeAction = {[unowned self] in
                self.multipleCompleteOnClick?(self.selectedIndexs, self.selectedValues)
            }
        }
    }
    
    private var multipleColsData: [[String]]? {
        didSet {
            if let multipleData = multipleColsData {
                for _ in multipleData.indices {
                    selectedIndexs.append(0)
                    selectedValues.append(" ")
                }
            }
        }
    }
    
    private var defalultSelectedIndexs: [Int]? {
        didSet {
            if let defaultIndexs = defalultSelectedIndexs {
                defaultIndexs.enumerated().forEach({ (component, row) in
                    assert(component < pickerView.numberOfComponents && row < pickerView.numberOfRows(inComponent: component), "设置的默认选中Indexs有不合法的")
                    if component < pickerView.numberOfComponents && row < pickerView.numberOfRows(inComponent: component) {
                        // 滚动到默认位置
                        pickerView.selectRow(row, inComponent: component, animated: false)
                        // 设置默认值
                        selectedIndexs[component] = row
                        selectedValues[component] = self.pickerView(pickerView, titleForRow: row, forComponent: component) ?? " "
                    }
                })
            } else {
                multipleColsData?.indices.forEach({ (index) in
                    // 滚动到默认位置
                    pickerView.selectRow(0, inComponent: index, animated: false)
                    // 设置默认选中值
                    selectedIndexs[index] = 0
                    selectedValues[index] = self.pickerView(pickerView, titleForRow: 0, forComponent: index) ?? " "
                })
            }
        }
    }
    
    
    private var selectedIndexs: [Int] = []
    private var selectedValues: [String] = []
    
    
    
    
    
    private lazy var pickerView: UIPickerView = { [unowned self] in
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    private lazy var tool: ToolBarView = ToolBarView()
    
    private let pickerViewHeight: CGFloat = 216.0
    private let toolBarHeight: CGFloat = 44.0
    
    let screenW = UIScreen.main.bounds.size.width
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension Picker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
    }
    
}





