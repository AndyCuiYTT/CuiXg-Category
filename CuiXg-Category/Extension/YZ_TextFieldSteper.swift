//
//  YZ_TextFieldSteper.swift
//  CuiXg-Category
//
//  Created by HYZ on 2020/9/25.
//  Copyright © 2020 CuiXg. All rights reserved.
//

// swiftlint:disable type_name

import UIKit

class YZ_TextFieldSteper: UIView {

    var minimumValue = 1
    var maxmumValue = 999
    var stepSize = 1   // the size of each step
    var currentValue = "1" {
        didSet {
            textfeild.text = currentValue
        }
    }//textfeild value

    let textfeild = UITextField()
    let decrementBtn = UIButton()
    let incrementBtn = UIButton()
    var stepEndEditNumBlock :((_ num:Int)->Void)?
    var decrementImage : String = "mall_shopCardec" {
        didSet{
            decrementBtn.setImage(UIImage.init(named: "\(decrementImage)"), for: .normal)
        }
    }
    var incrementImage : String = "mall_shopCarAdd" {
        didSet{
            incrementBtn.setImage(UIImage.init(named: "\(incrementImage)"), for: .normal)
        }
    }

    var textFeildbackColor :UIColor = UIColor.white {
        didSet{
            textfeild.backgroundColor = textFeildbackColor
        }
    }



    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(decrementBtn)
        decrementBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(self.snp_height)
        }

        decrementBtn.addTarget(self, action: #selector(decrementBtnClick), for: .touchUpInside)




        self.addSubview(incrementBtn)
        incrementBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(self.snp_height)
        }
        incrementBtn.addTarget(self, action: #selector(incrementBtnClick), for: .touchUpInside)

        self.addSubview(textfeild)
        textfeild.keyboardType = .numberPad
        textfeild.textColor = QWColor.text_000
        textfeild.font = QWFont.R_12PT
        textfeild.backgroundColor = textFeildbackColor
        textfeild.textAlignment = .center
        textfeild.text = currentValue
        textfeild.snp.makeConstraints { (make) in
            make.left.equalTo(decrementBtn.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(incrementBtn.snp.left)
        }

        textfeild.addTarget(self, action: #selector(productCountTextFieldEditingDidEnd(_:)), for: .editingDidEnd)


        let line1 = UIView()
        textfeild.addSubview(line1)
        line1.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }

        let line2 = UIView()
        textfeild.addSubview(line2)
        line2.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8156862745, blue: 0.8156862745, alpha: 1)
        line2.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0.5)
        }


        self.layer.masksToBounds = true
        self.layer.cornerRadius =  4
        self.layer.borderWidth = 0.5
        self.layer.borderColor =   #colorLiteral(red: 0.8196078431, green: 0.8156862745, blue: 0.8156862745, alpha: 1).cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension YZ_TextFieldSteper {
    @objc func decrementBtnClick(){

        if Int(textfeild.text!) ?? 0 <= minimumValue  {
            #if DEBUG
               print("YZ_TextFieldSteper 已经最小了")

            #endif
            decrementBtn.isEnabled = false
            return
        }

        if  var  numberofstr =  Int(textfeild.text!){
            numberofstr  -= stepSize
            textfeild.text = "\(numberofstr)"

        }
        incrementBtn.isEnabled = true

        if let num = Int(textfeild.text!) {
            self.stepEndEditNumBlock?(num)
        }


    }

    @objc func incrementBtnClick(){
        if Int(textfeild.text!) ?? 0 >= maxmumValue  {
            #if DEBUG
               print("YZ_TextFieldSteper 已经最最大了")

            #endif
            incrementBtn.isEnabled = false
            return
        }

        if  var  numberofstr =  Int(textfeild.text!){
            numberofstr += stepSize
            textfeild.text = "\(numberofstr)"

        }

        decrementBtn.isEnabled = true
        if let num = Int(textfeild.text!) {
            self.stepEndEditNumBlock?(num)
        }
    }


    @objc private func productCountTextFieldEditingDidEnd(_ sender: UITextField) {
        if let countStr = sender.text, let count = Int(countStr) {
            if count < Int(minimumValue){
                sender.text = "1"
                decrementBtn.isEnabled = false
            }
            if  count > maxmumValue{
                sender.text = "\(maxmumValue)"
                incrementBtn.isEnabled = false
            }

            if let num = Int(sender.text!) {
                self.stepEndEditNumBlock?(num)
            }

        }else {
            sender.text = "1"
            currentValue =  "1"
            self.stepEndEditNumBlock?(1)

        }

    }

}
