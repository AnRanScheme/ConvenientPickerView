//
//  PickerTextField.swift
//  ConvenientPickerView
//
//  Created by 安然 on 17/3/21.
//  Copyright © 2017年 安然. All rights reserved.
//

import UIKit

open class PickerTextField: UITextField {
    
    public typealias ButtonAction = () -> Void
    public typealias SingleCompleteAction = (_ textField: UITextField,_ selectedIndex: Int, _ selectedValue: String) -> Void
    public typealias MultipleCompleteAction = (_ textField: UITextField,_ selectedIndexs: [Int], _ selectedValues: [String]) -> Void
    public typealias DateCompleteAction = (_ textField: UITextField,_ selectedDate: Date) -> Void
    
    public typealias MultipleAssociatedDataType = [[[String: [String]?]]]

    ///  保存pickerView的初始化
    fileprivate var setUpPickerClosure:(() -> PickerView)?
    ///  如果设置了autoSetSelectedText为true 将自动设置text的值, 默认以空格分开多列选择, 但你仍然可以在响应完成的closure中修改text的值
    fileprivate var autoSetSelectedText = false
    
    //MARK: 初始化
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    // 从xib或storyboard中初始化时候调用
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("\(self.debugDescription) --- 销毁")
    }

}

// MARK: - 监听通知
extension PickerTextField {
    
    fileprivate func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didBeginEdit),
                                               name: NSNotification.Name.UITextFieldTextDidBeginEditing,
                                               object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEndEdit),
                                               name: NSNotification.Name.UITextFieldTextDidEndEditing,
                                               object: self)
    }
    // 开始编辑添加pickerView
    @objc func didBeginEdit()  {
        let pickerView = setUpPickerClosure?()
        pickerView?.delegate = self
        inputView = pickerView
    }
    // 编辑完成销毁pickerView
    @objc func didEndEdit() {
        inputView = nil
    }
    
    override open func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
}

extension PickerTextField: PickerViewDelegate {
    
    public func singleColDidSelected(_ selectedIndex: Int, selectedValue: String) {
        if autoSetSelectedText {
            text = " " + selectedValue
        }
    }
    
    public func multipleColsDidSelected(_ selectedIndexs: [Int], selectedValues: [String]) {
        
        
        if autoSetSelectedText {
            text = selectedValues.reduce("", { (result, selectedValue) -> String in
                result + " " + selectedValue
            })
        }
    }
    
    public func dateDidSelected(_ selectedDate: Date) {
        if autoSetSelectedText {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.string(from: selectedDate)
            text = " " + string
        }
    }
    
}

// MARK: - 使用方法
extension PickerTextField {
    
    /// 单列选择器
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据
    ///  - parameter defaultSeletedIndex:        默认选中的行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter completeAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showSingleColPicker(_ toolBarTitle: String,
                                    data: [String],
                                    defaultSelectedIndex: Int?,
                                    autoSetSelectedText: Bool,
                                    completeAction: SingleCompleteAction?) {
        
        self.autoSetSelectedText = autoSetSelectedText
        
        // 保存在这个closure中, 在开始编辑的时候在执行, 避免像之前在这里直接初始化pickerView, 每个SelectionTextField在调用这个方法的时候就初始化pickerView,当有多个pickerView的时候就很消耗内存
        setUpPickerClosure = {() -> PickerView in
            
            return PickerView.singleColPicker(toolBarTitle, singleColData: data, defaultIndex: defaultSelectedIndex, cancelAction: {[unowned self] in
                
                self.endEditing(true)
                
                }, completeAction: {[unowned self] (selectedIndex: Int, selectedValue: String) -> Void in
                    
                    completeAction?(self, selectedIndex, selectedValue)
                    self.endEditing(true)
                    
            })
            
            
        }
        
    }
    
    /// 多列不关联选择器
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据
    ///  - parameter defaultSeletedIndexs:       默认选中的每一列的行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将俺默认的格式自动设置textField的值
    ///  - parameter completeAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showMultipleColsPicker(_ toolBarTitle: String, data: [[String]], defaultSelectedIndexs: [Int]?, autoSetSelectedText: Bool, completeAction: MultipleCompleteAction?) {
        self.autoSetSelectedText = autoSetSelectedText
        
        setUpPickerClosure = {() -> PickerView in
            
            return PickerView.multipleCosPicker(toolBarTitle, multipleColsData: data, defaultSelectedIndexs: defaultSelectedIndexs, cancelAction: { [unowned self] in
                
                self.endEditing(true)
                
                }, completeAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    completeAction?(self, selectedIndexs, selectedValues)
                    self.endEditing(true)
            })
        }
        
    }
    
    /// 多列关联选择器
    ///
    ///  - parameter title:                      标题
    ///  - parameter data:                       数据, 数据的格式参照示例
    ///  - parameter defaultSeletedIndexs:       默认选中的每一列的行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter completeAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showMultipleAssociatedColsPicker(_ toolBarTitle: String, data: MultipleAssociatedDataType, defaultSelectedValues: [String]?,autoSetSelectedText: Bool, completeAction: MultipleCompleteAction?) {
        self.autoSetSelectedText = autoSetSelectedText
        
        setUpPickerClosure = {() -> PickerView in
            
            return PickerView.multipleAssociatedCosPicker(toolBarTitle, multipleAssociatedColsData: data, defaultSelectedValues: defaultSelectedValues,cancelAction: { [unowned self] in
                
                self.endEditing(true)
                
                }, completeAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    completeAction?(self, selectedIndexs, selectedValues)
                    self.endEditing(true)
            })
        }
        
    }
    
    
    /// 城市选择器
    ///
    ///  - parameter title:                      标题
    ///  - parameter defaultSeletedValues:       默认选中的每一列的值, 注意不是行数
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter completeAction:                 响应完成的Closure
    ///
    ///  - returns:
    
    public func showCitiesPicker(_ toolBarTitle: String, defaultSelectedValues: [String]?,autoSetSelectedText: Bool, completeAction: MultipleCompleteAction?) {
        self.autoSetSelectedText = autoSetSelectedText
        
        setUpPickerClosure = {() -> PickerView in
            return PickerView.citiesPicker(toolBarTitle, defaultSelectedValues: defaultSelectedValues, cancelAction: { [unowned self] in
                self.endEditing(true)
                
                }, completeAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    completeAction?(self,selectedIndexs, selectedValues)
                    self.endEditing(true)
            })
        }
        
    }
    
    /// 日期选择器
    ///
    ///  - parameter title:                      标题
    ///  - parameter datePickerSetting:          可配置UIDatePicker的样式
    ///  - parameter autoSetSelectedText:        设置为true的时候, 将按默认的格式自动设置textField的值
    ///  - parameter completeAction:                 响应完成的Closure
    ///
    ///  - returns:
    public func showDatePicker(_ toolBarTitle: String, datePickerSetting: DatePickerSetting = DatePickerSetting(), autoSetSelectedText: Bool, completeAction: DateCompleteAction?) {
        self.autoSetSelectedText = autoSetSelectedText
        
        setUpPickerClosure = {() -> PickerView in
            return PickerView.datePicker(toolBarTitle, datePickerSetting: datePickerSetting, cancelAction: { [unowned self] in
                self.endEditing(true)
                
                }, completeAction: {[unowned self]  (selectedDate) in
                    completeAction?(self, selectedDate)
                    self.endEditing(true)
                    
            })
            
        }
    }

    
}
