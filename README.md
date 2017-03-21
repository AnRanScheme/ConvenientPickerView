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
