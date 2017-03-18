//
//  ViewController.swift
//  NLP57309201
//
//  Created by hudsioo on 7/24/2558 BE.
//  Copyright (c) 2558 QOOFHOUSE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ช่องกรอกชื่อพ่อ: UITextField!
    @IBOutlet weak var ช่องกรอกชื่อแม่: UITextField!

    @IBOutlet weak var จำนวนความสัมพันธ์: UILabel!
    @IBOutlet weak var ปุ่มเพิ่มลดความสัมพันธ์: UIStepper!
    @IBOutlet weak var แสดงผลลัพธ์: UITextView!
    
    @IBAction func เพิ่มลดความสัมพันธ์(_ sender: AnyObject) {
        let stepper : UIStepper = (sender as? UIStepper)!
        จำนวนความสัมพันธ์.text = Int(stepper.value).description
   
    }
    
    @IBAction func ประมวลผลลัพธ์(_ sender: AnyObject) {
        let n :String = จำนวนความสัมพันธ์.text!
        let nameThai = NameThai(พ่อ: ช่องกรอกชื่อพ่อ.text!, แม่: ช่องกรอกชื่อแม่.text!, จำนวนตัวอักษรที่สัมพันธ์กัน: Int(n)!)
        แสดงผลลัพธ์.text = dictionaryArrayToStringFormat(nameThai.resultDic)
        print(nameThai.resultDic)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ปุ่มเพิ่มลดความสัมพันธ์.minimumValue = 0
        ปุ่มเพิ่มลดความสัมพันธ์.maximumValue = 5
        
    }
    
    func dictionaryArrayToStringFormat(_ dic :Dictionary<String, Int>) -> String{
        var returnString = ""
        for name in dic{
            let tmpString = "ชื่อ : \(name.0) \t ค่าอาตยะ : \(name.1)\n"
            returnString += tmpString
        }
        return returnString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


