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
        self.testModelObj.path = path
       
     sut.personsArray = []
        let exp = expectation(description: "load data")
        testModelObj.requestURL(url:"" ,pageNo: 1 , completion: { result in
            self.sut.personsArray.append(contentsOf: result)
            XCTAssertNotNil(result)
            print(result)
            exp.fulfill()
            XCTAssert( self.sut.personsArray.count == 20)
            self.testViewObj.fetchingDataSuccess()
        })
        wait(for: [exp], timeout: 10)
        
        
    }

    func testPullToRefresh(){
        let testBundle = Bundle(for: type(of: self))
        guard let  path = testBundle.path(forResource: "data", ofType: "json") else {
            print("no path")
            return  }
        let exp = expectation(description: "load data")
        testModelObj.path = path
        testModelObj.requestURL(url:"",pageNo: 1, completion: { result in
            self.sut.personsArray.append(contentsOf: result)
            XCTAssertNotNil(result)
            print(result)
            exp.fulfill()
            XCTAssert( self.sut.personsArray.count == 20)
            //self.testViewObj.fetchingDataSuccess()
        })
        wait(for: [exp], timeout: 10)
        
        sut.reloadUI()
        //XCTAssertEqual(self.personsArray.count, 0)
       XCTAssertEqual(sut.personsArray.count, 20)
    
    }
    
    func testLoadMore(){
        let testBundle = Bundle(for: type(of: self))
        guard let  path = testBundle.path(forResource: "data", ofType: "json") else {
            print("no path")
            return  }
        let exp = expectation(description: "load data")
        testModelObj.path = path
        sut.pageNumber = 2
        testModelObj.requestURL(url:"",pageNo: 2, completion: { result in
            self.sut.personsArray.append(contentsOf: result)
            XCTAssertNotNil(result)
            print(result)
            exp.fulfill()
            XCTAssert(self.sut.personsArray.count == 20)
            self.testViewObj.fetchingDataSuccess()
        })
        wait(for: [exp], timeout: 10)
        
        sut.loadMore()
        XCTAssertEqual(sut.personsArray.count, 40)
        
    }
    

}
