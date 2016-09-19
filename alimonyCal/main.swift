//
//  main.swift
//  alimonyCal
//
//  Created by sue on 15/7/8.
//  Copyright (c) 2015年 sue. All rights reserved.
//

import Foundation

extension Double {
    func format(_ f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
}
var xMan = ["Sue","Peach","Kseven"]
var consume: [NSDictionary] = [
    ["name":"番茄鱼(苏)", "allM":"24", "who":"Sue", "share":[0,1,2]],
    ["name":"一周菜(苏)", "allM":"28", "who":"Sue", "share":[0,1,2]],
    ["name":"晚菜(苏)", "allM":"5", "who":"Sue", "share":[0,1,2]],
    ["name":"超市红糖(康)", "allM":"7.2", "who":"Kseven", "share":[0]],
    ["name":"超市(康)", "allM":"21.7", "who":"Kseven", "share":[1]],
    ["name":"超市公共(康)", "allM":"38.58", "who":"Kseven", "share":[0,1,2]],
    ["name":"KTV(苏)", "allM":"58", "who":"Sue", "share":[0,1,2]],
    ["name":"晚餐(桃)", "allM":"35", "who":"Peach", "share":[0,1,2]]
]

func mains(_ xMan:[String],consume:[NSDictionary]) {
    /// 初始化
    let cloumns = xMan.count+2 //列
    let consumeCount = consume.count+2 //行
    var table : [[String]] = Array(repeating: Array(repeating: "0.00", count: cloumns), count: consumeCount)
    table[0][cloumns-1] = "项目（付钱人）"; table[0][cloumns-2] = "ALL"; table[consume.count+1][cloumns-1] = "总计";
    for index in 0 ..< cloumns-2 {
        table[0][index] = xMan[index] as String
    }
    for index in 1 ..< consumeCount-1 {
        table[index][cloumns-1] = consume[index-1]["name"] as! String //第一列 名称
        table[index][cloumns-2] = consume[index-1]["allM"] as! String // 第二列 总计
    }
    /// 计算每条项目
    for i in 0 ..< consume.count {
        let allM = (consume[i]["allM"] as! NSString).doubleValue //总价格
        let personNumber: Double = Double((consume[i]["share"]! as AnyObject).count) //参与的人数
        let moneyTemp: Double = allM / personNumber
        // 去修改table里面相对应的人的价格
        for temp in consume[i]["share"] as! [Int]{
            table[i+1][temp] =  moneyTemp.description //String(stringInterpolationSegment: moneyTemp)
        }
    }
    //计算出总价
    for j in 0 ..< cloumns-1 {
        var counts:Double = 0;
        for i in 0 ..< consumeCount-1 {
            counts += (table[i][j] as NSString).doubleValue
        }
        table[consumeCount-1][j] = counts.description
    }
    // 输出报表
    var table2 : [[String]] = table
    for index1 in 0 ..< table2.count {
        for index2 in 0 ..< table2[index1].count {
            
            if(index1 == 0 && index2 < cloumns-1 ){
                print(NSString(format: "|%-10s", (table2[index1][index2]as NSString).utf8String! ), terminator: "")
                
            }else if (index2 == cloumns-1) {
                print(NSString(format: "|%@       ", table2[index1][index2] ), terminator: "")
            }else{
                var table2Temp : NSString = table2[index1][index2]as NSString;
                if( (table2[index1][index2]as NSString).length > 6){
                    table2Temp = (table2[index1][index2]as NSString).substring(to: 6) as NSString
                }
                print(String(format: "|%-10s", table2Temp.utf8String!), terminator: "")
            }
        }
        print("")
    }
    
    
    
    //-----------------计算出谁该给谁
    //table[consumeCount-1][2] //第一个人的花费
    var selfSpend:[Double] = Array(repeating: 0.0, count: xMan.count); //每个人花费的数组
    var allSpend = Array(repeating: ["name":"xx","ap":0.0,"fp":0.0,"sp":0.0], count: xMan.count)
    var j = 0;
    print("/******************每人支出情况，正数为收费，负数为需支出多少*******************/")
    for i in 0 ..< cloumns-2 {
        allSpend[j]["name"] = xMan[j] //人
        allSpend[j]["fp"] =  (table[consumeCount-1][i] as NSString).doubleValue //消费
        //计算支出
        for index in 0 ..< consume.count {
            if allSpend[j]["name"]as! String == consume[index]["who"]as! String { //此人有支出
                allSpend[j]["ap"] =  allSpend[j]["ap"]as! Double + (consume[index]["allM"]as! NSString).doubleValue
                continue
            }
        }
        allSpend[j]["sp"] = (allSpend[j]["ap"]as! Double) - (allSpend[j]["fp"]as! Double)//支出-消费
        print("\(allSpend[j]["name"]!)    \(allSpend[j]["sp"]!)")
        j += 1;
    }
    //根据支出-消费进行数组排序，从小到大
    for i in 0 ..< allSpend.count - 1 {
        for j in 0 ..< allSpend.count - 1 - i {
            if ((allSpend[j]["sp"]as! Double) > (allSpend[j + 1]["sp"]as! Double)) {
                let temp = allSpend[j]["sp"]; //交换支出
                allSpend[j]["sp"] = allSpend[j+1]["sp"];
                allSpend[j+1]["sp"] = temp;
                let temp1 = allSpend[j]["name"]; //交换姓名
                allSpend[j]["name"] = allSpend[j+1]["name"];
                allSpend[j+1]["name"] = temp1;
                
            }
        }
    }
    print("/******************计算结果*******************/")
    var jj = allSpend.count - 1
    var i = 0;
    while i < allSpend.count  {
        if (allSpend[i]["sp"]as! Double) >= 0.0 {
            break
        }else if(i>=jj){
            break
        }
        else{
            if(fabs(allSpend[i]["sp"]as! Double) <= (allSpend[jj]["sp"]as! Double)) {
                let calTemp1: Double = (allSpend[jj]["sp"]as! Double) + (allSpend[i]["sp"]as! Double)
                print("\( allSpend[i]["name"]!)给\(allSpend[jj]["name"]!)  \( fabs(allSpend[i]["sp"]as! Double))")
                allSpend[jj]["sp"] = calTemp1
                if(calTemp1 == 0.0){
                    jj -= 1
                }
                i += 1
                continue
            } else {
                print("\(allSpend[i]["name"]!)给\(allSpend[jj]["name"]!)  \(fabs(allSpend[jj]["sp"]as! Double))")
                let calTemp2: Double = (allSpend[i]["sp"]as! Double) + (allSpend[jj]["sp"]as! Double)
                allSpend[i]["sp"] = calTemp2
                jj -= 1
            }
        }
    }
}
mains(xMan, consume: consume)







