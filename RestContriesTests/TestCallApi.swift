//
//  TestCallApi.swift
//  
//
//  Created by Adam on 7/18/20.
//

import XCTest
@testable import RestContries
import OHHTTPStubs

class CallingApiTest: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        //MARK: - Given
        stub(condition: { (requestURl) -> Bool in
            return requestURl.url?.absoluteString.contains("name")  ?? false
        }) { (response) -> HTTPStubsResponse in
            
            let jsonObject: [[String: Any]] =  [[
                "name": "Egypt",
                "capital": "Cairo"
            ]]
            return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: nil)
        }
        var expectedResponse: [SearchCountryModel.CountryModel]?  = nil
        let exception = self.expectation(description: "calling Api failed !")
        
        //MARK: - When
        let worker: ISearchCountryWorker? = SearchCountryWorker()
        worker?.getAllCountries(parameters: ["name": "Egypt"], complition: { (error, status, response) in
            expectedResponse = response
            exception.fulfill()
        })
        
        //MARK: - Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(expectedResponse)
        XCTAssertTrue(expectedResponse?[0].capital == "Cairo" , "Not Matched")
        XCTAssertEqual(expectedResponse?[0].name , "Egypt" , "Not Matched")
        
    }
    
}

