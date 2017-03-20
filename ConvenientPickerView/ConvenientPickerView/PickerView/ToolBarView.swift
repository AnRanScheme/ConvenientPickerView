//
//  ToolBarView.swift
//  ConvenientPickerView
//
//  Created by 安然 on 17/3/20.
//  Copyright © 2017年 安然. All rights reserved.
// github: https://github.com/AnRanScheme/ConvenientPickerView.git
// 简书: 

import UIKit

class ToolBarView: UIView {
    
    typealias CustomClosures = (_ titleLabel: UILabel, _ cancelButton: UIButton, _ completeButton: UIButton) -> ()

    public typealias ButtonAction = () -> ()
    
    public var completeAction: ButtonAction?
    
    public var cancelAction: ButtonAction?
    
    public var title = "请选择" {
        didSet {
            titleLabel.text = title
        }
    }
    
    /// 主题文本框
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor     = UIColor.white
        return label
    }()
    
    /// 取消按钮
    private lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    /// 完成按钮
    private lazy var completeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    /// 菜单栏
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = UIColor.lightText
        addSubview(contentView)
        contentView.addSubview(completeButton)
        contentView.addSubview(cancelButton)
        contentView.addSubview(titleLabel)
        cancelButton.addTarget(self,
                               action: #selector(completeButtonOnClick(sender:)),
                               for: .touchUpInside)
        completeButton.addTarget(self,
                                 action: #selector(cancelButtonOnClick(sender:)),
                                 for: .touchUpInside)
    }
    
    func completeButtonOnClick(sender: UIButton) {
        completeAction?()
    }
    
    func cancelButtonOnClick(sender: UIButton) {
        cancelAction?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 15.0
        let contentHeight = bounds.size.height - 2.0
        contentView.frame = CGRect(x: 0.0,
                                   y: 1.0,
                                   width: bounds.size.width,
                                   height: contentHeight)
        
        let btnWidth = contentHeight
        cancelButton.frame = CGRect(x: margin,
                                    y: 0.0,
                                    width: btnWidth,
                                    height: btnWidth)
        completeButton.frame = CGRect(x: bounds.size.width - btnWidth - margin,
                                      y: 0.0,
                                      width: btnWidth,
                                      height: btnWidth)
        
        let titleX = cancelButton.frame.maxX + margin
        let titleW = bounds.size.width - titleX - btnWidth - margin
        titleLabel.frame = CGRect(x: titleX, y: 0.0, width: titleW, height: btnWidth)
  
    }

}
