# ConvenientPickerView
一款方便的PickerView,通过简单的代码设置可以实现UIPickerView,无需代理设置,回收之后还会移除,可以设置多种类型的UIPickerView

![这是列子](https://github.com/AnRanScheme/ConvenientPickerView/raw/master/ConvenientPickerView/anran.gif)


1. TextField支持xib和代码生成使用, 只需调用一个方法, 设置选择的数据, 和默认选中的项(可选设置),可以设置是否在滚动的时候自动填充选中的值, 然后是在closure中处理点击完成的响应

        // 代码生成
        let test = PickerTextField(frame: CGRect(x: 20, y: timeTextField.frame.maxY, width: 340, height: 28))
        test.borderStyle = .roundedRect
        test.placeholder = "代码初始化"
        test.showSingleColPicker("测试代码", data: singleData, defaultSelectedIndex: 0, autoSetSelectedText: true) { [unowned self] (textField, selectedIndex, selectedValue) in
        print(selectedValue)
        self.selectedDataLabel.text = selectedValue
        }
        view.addSubview(test)
        
 TextField的    例子 
![这是列子](https://github.com/AnRanScheme/ConvenientPickerView/raw/master/ConvenientPickerView/anran2.gif)

2. 按钮(点击事件)中的使用, 只需要在相应的点击事件中使用UsefulPickerView的class方法即可, 这些方法和TextField的参数和使用完全相同, 多的一个效果就是点击背景会移除选择器

        ConvenientPickerView.showSingleColPicker("单列数据",
                                                 data: singleData,
                                                 defaultSelectedIndex: 2) { [unowned self]
                                                    (selectIndex, selectValue) in
                                                    self.selectedLabel.text = "选中了第\(selectIndex)行----选中的数据为\(selectValue)"
        }
        
 Buttond的    例子 
![这是列子](https://github.com/AnRanScheme/ConvenientPickerView/raw/master/ConvenientPickerView/anran1.gif)
        


3. UsefulPickerView. 处理弹出和移除view


        func hidePicker() {
                // 把self从window中移除
                UIView.animate(withDuration: 0.25, animations: { [unowned self] in
                    self.backgroundColor = UIColor.clear
                    self.pickerView.frame = self.hideFrame
            
                    }, completion: {[unowned self] (_) in
                        self.removeFromSuperview()
                })
            }


        func hidePicker() {
                // 把self从window中移除
                UIView.animate(withDuration: 0.25, animations: { [unowned self] in
                    self.backgroundColor = UIColor.clear
                    self.pickerView.frame = self.hideFrame
            
                    }, completion: {[unowned self] (_) in
                        self.removeFromSuperview()
                })
            }
            
            
4. 如果你觉得还不错那就不要吝啬你的星星,当然本文章应用了大量大神的思路,好吧我就是练练
            

