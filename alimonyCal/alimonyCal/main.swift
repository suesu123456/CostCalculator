//
//  main.swift
//  alimonyCal
//
//  Created by sue on 15/7/8.
//  Copyright (c) 2015年 sue. All rights reserved.
//

import Foundation

struct ColorLog {
    static let ESCAPE = "\u{001b}["
    
    static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    static let RESET = ESCAPE + ";"   // Clear any foreground or background color
    
    static func red<T>(object:T) {
        print("\(ESCAPE)fg255,0,0;\(object)\(RESET)")
    }
    
    static func green<T>(object:T) {
        print("\(ESCAPE)fg0,255,0;\(object)\(RESET)")
    }
    
    static func blue<T>(object:T) {
        print("\(ESCAPE)fg0,0,255;\(object)\(RESET)")
    }
    
    static func yellow<T>(object:T) {
        print("\(ESCAPE)fg255,255,0;\(object)\(RESET)")
    }
    
    static func purple<T>(object:T) {
        print("\(ESCAPE)fg255,0,255;\(object)\(RESET)")
    }
    
    static func cyan<T>(object:T) {
        print("\(ESCAPE)fg0,255,255;\(object)\(RESET)")
    }
}

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}

var xMan = ["Anne","Bellis","Sue","Tommao","Lagel","Jiaqin","Bo","Peach","Dong"]
var consume = [
    ["name":"黄酒","allM":"22.0","who":"Tommao","share":[0,1,2,3,4,5,6]],
    ["name":"午餐","allM":"148.0","who":"Sue","share":[1,2,3,6,7,8]]
    ]

    /// 初始化
    var cloumns = xMan.count+2 //列
    var consumeCount = consume.count+2 //行
    var table : [[String]] = Array(count: consumeCount, repeatedValue: Array(count: cloumns, repeatedValue: "0.00"))
    table[0][0] = "项目"; table[0][1] = "总共"; table[consume.count+1][0] = "总计";
    for var index = 2; index < cloumns; index++ {
        table[0][index] = xMan[index-2] as String
    }
    for var index = 1; index < consumeCount-1; index++ {
        table[index][0] = consume[index-1]["name"] as! String //第一列 名称
        table[index][1] = consume[index-1]["allM"] as! String // 第二列 总计
    }
    /// 计算每条项目
    for var i = 0; i<consume.count; i++ {
        var allM = (consume[i]["allM"] as! NSString).doubleValue //总价格
        var personNumber: Double = Double(consume[i]["share"]!.count) //参与的人数
        var moneyTemp: Double = allM / personNumber
        // 去修改table里面相对应的人的价格
        for temp in consume[i]["share"] as! [Int]{
            table[i+1][temp+2] =  moneyTemp.description //String(stringInterpolationSegment: moneyTemp)
        }
    }
    //计算出总价
    for var j = 1; j < cloumns; j++ {
        var counts:Double = 0;
        for var i = 1; i < consumeCount-1; i++ {
            counts += (table[i][j] as NSString).doubleValue
        }
        table[consumeCount-1][j] = counts.description
    }
    // 输出报表
    var table2 : [[String]] = table
    for var index1 = 0; index1<table2.count; index1++ {
        for var index2 = 0; index2<table2[index1].count; index2++ {
            
            if(index1 == 0 || index2 < 2 ){
                ColorLog.green(table2[index1][index2])
                print("    |    ")
            }
            else{
                print((table2[index1][index2]as NSString).substringToIndex( 4 ))
                print("    |    ")
            }
        }
        println()
    }



    //-----------------计算出谁该给谁
//    table[consumeCount-1][2] //第一个人的花费
    var selfSpend:[Double] = Array(count: xMan.count, repeatedValue: 0.0); //每个人花费的数组
    var allSpend = Array(count: xMan.count, repeatedValue: ["name":"xx","ap":0.0,"fp":0.0,"sp":0.0])
    var j = 0;
    for var i = 2; i < cloumns; i++ {
        allSpend[j]["name"] = xMan[j] //人
        allSpend[j]["fp"] =  (table[consumeCount-1][i] as NSString).doubleValue //消费
        //计算支出
        for var index = 0; index < consume.count; index++ {
            if allSpend[j]["name"]as! String == consume[index]["who"]as! String { //此人有支出
                allSpend[j]["ap"] = (consume[index]["allM"]as! NSString).doubleValue
            }
        }
        allSpend[j]["sp"] = (allSpend[j]["ap"]as! Double) - (allSpend[j]["fp"]as! Double)//支出-消费
//        println(allSpend[j]["sp"])
        j++;
    }
    //根据支出-消费进行数组排序，从小到大
    for var i = 0; i < allSpend.count - 1; i++ {
        for var j = 0; j < allSpend.count - 1 - i; j++ {
            if ((allSpend[j]["sp"]as! Double) > (allSpend[j + 1]["sp"]as! Double)) {
                var temp = allSpend[j]["sp"]; //交换支出
                allSpend[j]["sp"] = allSpend[j+1]["sp"];
                allSpend[j+1]["sp"] = temp;
                var temp1 = allSpend[j]["name"]; //交换姓名
                allSpend[j]["name"] = allSpend[j+1]["name"];
                allSpend[j+1]["name"] = temp1;
                
            }
        }
    }

    var jj = allSpend.count - 1
    for var i = 0; i < allSpend.count ;  {
        
        if (allSpend[i]["sp"]as! Double) >= 0.0 {
            break
        }else if(i>=jj){
            break
        }
        else{
            if(fabs(allSpend[i]["sp"]as! Double) <= (allSpend[jj]["sp"]as! Double)) {
                var calTemp1: Double = (allSpend[jj]["sp"]as! Double) + (allSpend[i]["sp"]as! Double)
                NSLog("%@给%@  %.2lf", allSpend[i]["name"]!, allSpend[jj]["name"]!, fabs(allSpend[i]["sp"]as! Double))
                allSpend[jj]["sp"] = calTemp1
                if(calTemp1 == 0.0){
                    --jj
                }
                i++
                continue
            } else {
                NSLog("%@给%@  %.2lf", allSpend[i]["name"]!, allSpend[jj]["name"]!, fabs(allSpend[jj]["sp"]as! Double))
                var calTemp2: Double = (allSpend[i]["sp"]as! Double) + (allSpend[jj]["sp"]as! Double)
                allSpend[i]["sp"] = calTemp2
                --jj
            }
        }
    }



//func addAndSubtract(a:Int, b:Int) -> (Int, Int){
//    return (a + b, a - b)
//}
//
//// 返回两个值
//var (result1, result2) = addAndSubtract(10, 5)
//
//println(result1)









