//
//  TestAlimonyCal.swift
//  TestAlimonyCal
//
//  Created by TanJie on 15/7/23.
//  Copyright (c) 2015年 sue. All rights reserved.
//

import Cocoa
import XCTest

class TestAlimonyCal: XCTestCase {

    let customers = ["Anne","Bellis","Sue","Tommao","Lagel","Jiaqin","Bo","Peach","Daihua"];

    let success: [NSArray] = [
        ["Anne", "Bellis", "Sue", "Tommao", "Lagel", "Jiaqin", "Bo", "Peach", "Daihua", "ALL", "项目（付钱人）"],
        ["2.85714285714286", "2.85714285714286", "2.85714285714286", "2.85714285714286", "2.85714285714286", "0.00", "2.85714285714286", "2.85714285714286", "0.00", "20.0", "7.4黄酒，油（毛）"],
        ["2.72", "0.00", "0.00", "2.72", "2.72", "2.72", "0.00", "2.72", "0.00", "13.6", "7.4猪肉，生菜面条（毛）"],
        ["5.57714285714286", "2.85714285714286", "2.85714285714286", "5.57714285714286", "5.57714285714286", "2.72", "2.85714285714286", "5.57714285714286", "0.0", "33.6", "总计"]
    ];

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAlimonyCalNoCustomers() {
        var result = alimoneyCal([], []);
        XCTAssertEqual([["没有消费者哦！"]], result);
    }

    func testAlimonyCalNoRecords() {
        var result = alimoneyCal(customers, []);
        XCTAssertEqual([["没有消费记录哟！"]], result);
    }

    func testAlimonyCalCustomersAndRecords() {
        let records: [NSDictionary] = [
            ["name":"7.4黄酒，油（毛）","allM":"20.0","who":"Tommao","share":["Anne","Bellis","Sue","Tommao","Lagel","Bo","Peach"]],
            ["name":"7.4猪肉，生菜面条（毛）","allM":"13.6", "who":"Tommao", "share":[0,4,5,3,7]]
        ];
        var result = alimoneyCal(customers, records);
        XCTAssertEqual(success, result);
    }

    func testAlimonyCalRecordsShareNotInCustomers() {
        let records: [NSDictionary] = [
            ["name":"7.4黄酒，油（毛）","allM":"20.0","who":"Tommao","share":["Anne","Bellis","Sue","Tommao","Lagel","Bo","7"]],
            ["name":"7.4猪肉，生菜面条（毛）","allM":"13.6", "who":"Tommao", "share":[0,4,5,3,7]]
        ];
        var result = alimoneyCal(customers, records);
        XCTAssertEqual([["消费者姓名不配对"]], result);
    }

    func testAlimonyCalRecordsShareMoreThanCustomers() {
        let records: [NSDictionary] = [
            ["name":"7.4黄酒，油（毛）","allM":"20.0","who":"Tommao","share":["Anne","Bellis","Sue","Tommao","Lagel","Bo","Peach"]],
            ["name":"7.4猪肉，生菜面条（毛）","allM":"13.6", "who":"Tommao", "share":[0,4,5,3,7,9]]
        ];
        var result = alimoneyCal(customers, records);
        XCTAssertEqual(success, result);
    }
    
}
