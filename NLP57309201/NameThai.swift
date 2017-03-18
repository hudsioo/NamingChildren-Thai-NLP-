//
//  NameThai.swift
//  NLP57309201
//
//  Created by hudsioo on 8/7/2558 BE.
//  Copyright (c) 2558 QOOFHOUSE. All rights reserved.
//

import Foundation

class NameThai {
    
    var artaya = [
        ["chars" : "ะาิีึืุูแโใไ", "artayaValue" : "6", "daos" : "อาทิตย์"],
        ["chars" : "กขคฆง", "artayaValue" : "15", "daos" : "จันทร์"],
        ["chars" : "จฉชซฌญ", "artayaValue" : "8", "daos" : "อังคาร"],
        ["chars" : "ฎฏฐฑฒณ", "artayaValue" : "17", "daos" : "พุธ"],
        ["chars" : "บปผฝพฟภม", "artayaValue" : "19", "daos" : "พฤหัสบดี"],
        ["chars" : "ศษสหฬฮ", "artayaValue" : "21", "daos" : "ศุกร์"],
        ["chars" : "ดตถทธน", "artayaValue" : "10", "daos" : "เสาร์"],
        ["chars" : "ยรลว", "artayaValue" : "12", "daos" : "ราหู"]]
    
    var m_name = [Any]()
    var f_name = [Any]()
    var resultDic : Dictionary<String, Int> = [:]
    
    init(พ่อ: String, แม่: String,จำนวนตัวอักษรที่สัมพันธ์กัน: Int){
        loadCorpusName()
        let relation = จำนวนตัวอักษรที่สัมพันธ์กัน
        let onMale = true
        let onFemale = true
        
        //var resultDic : Dictionary<String, Int> = [:]
        for n in m_name{
            let name = n as! String   
            if onMale && onFemale && countRelationChar(name, ผู้ปกครอง: พ่อ) >= relation && countRelationChar(name, ผู้ปกครอง: แม่) >= relation{
                resultDic[name] = artayaFromName(name)
                
            }else if onMale && countRelationChar(name, ผู้ปกครอง: พ่อ) >= relation{
                resultDic[name] = artayaFromName(name)
                
            }else if onFemale && countRelationChar(name, ผู้ปกครอง: แม่) >= relation {
                resultDic[name] = artayaFromName(name)
            }
            
        }

    }
    
    func getArtayaValue(_ name_c: Character) -> Int{
        for a :[String:String] in artaya {
            for c in (a["chars"]?.characters)!{
                if name_c == c {
                    return Int(a["artayaValue"]!)!
                }
            }
        }
        return 0
    }
    
    func artayaFromName(_ name: String) -> Int{
        var sum = 0
        for c in name.unicodeScalars{
            let char = Character(c)
            sum += getArtayaValue(char)
        }
        
        return complexSum(sum)
    }
    
    func complexSum(_ sum : Int)-> Int{
        return sum > 9 ? complexSum(sum/10+sum%10) : sum
    }
    
    func loadCorpusName(){
        let bundle = Bundle.main
        let m_path = bundle.path(forResource: "maleTH", ofType: "txt")
        m_name = (try! NSString(contentsOfFile: m_path!, encoding: String.Encoding.utf8.rawValue)).components(separatedBy: "\n")
        let f_path = bundle.path(forResource: "femaleTH", ofType: "txt")
        f_name = (try! NSString(contentsOfFile: f_path!, encoding: String.Encoding.utf8.rawValue)).components(separatedBy: "\n")
    }
    
    func countRelationChar(_ name : String, ผู้ปกครอง : String) -> Int{
        var countC = 0
        for m in ผู้ปกครอง.characters{
            if name.range(of: String(m)) != nil {
                countC += 1
            }
        }
        return countC
    }
    
}

extension String {
    var utf8Array: [UInt8] {
        return Array(utf8)
    }
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substring(with: (characters.index(startIndex, offsetBy: r.lowerBound) ..< characters.index(startIndex, offsetBy: r.upperBound)))
    }
}

