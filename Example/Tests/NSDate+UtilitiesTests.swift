//
//  NSDate+UtilitiesTests.swift
//  WQBasicModules_Tests
//
//  Created by hejinyin on 2018/4/17.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import XCTest
@testable import WQBasicModules
class NSDate_UtilitiesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
     
    }
    
    override func tearDown() {
 
        super.tearDown()
    }
 
    func test_create_date_with_week_in_year()  {
        let date = Date.date(ordinality: 1, in: 2018)!
        let expect = Date(timeIntervalSince1970: 1514649600)
        XCTAssertEqual(date, expect)
    }
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
