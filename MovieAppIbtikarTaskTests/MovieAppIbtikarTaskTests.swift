//
//  MovieAppIbtikarTaskTests.swift
//  MovieAppIbtikarTaskTests
//
//  Created by user on 9/23/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import XCTest
@testable import MovieAppIbtikar

class MovieAppIbtikarTaskTests: XCTestCase {
    var sut : ActorPresenter!
    var testViewObj : TestView!
    var testModelObj : TestModel!
    var personsArray:[Person]!
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testModelObj = TestModel()
        testViewObj = TestView()
        sut = ActorPresenter(viewProtocol:
            testViewObj, modelProtocol: testModelObj)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        testModelObj = nil
        testViewObj = nil
        super.tearDown()
        
    }
    
    func testLoadData(){
        let testBundle = Bundle(for: type(of: self))
        guard let  path = testBundle.path(forResource: "data", ofType: "json") else {
            print("no path")
            return  }
        var pageNumber = 1
        personsArray = []
        let exp = expectation(description: "load data")
        testModelObj.requestURL(url:path,pageNo:pageNumber, completion: { result in
            self.personsArray.append(contentsOf: result)
            XCTAssertNotNil(result)
            print(result)
            exp.fulfill()
            XCTAssert(self.personsArray.count == 20)
            self.testViewObj.fetchingDataSuccess()
        })
        wait(for: [exp], timeout: 10)
        
    }

    

}
