import XCTest
@testable import jLocation

final class jLocationTests: XCTestCase {
    
    var sut: JLocation!
    
    override func setUp() {
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_frameworkName() throws {
        let expectedFrameworkName = "jLocation"
        let actualFrameworkName = sut.jLocationFrameworkName
        
        XCTAssertEqual(expectedFrameworkName, actualFrameworkName)
    }
    
    func test_test() throws {
        let expectedFrameworkName = "jNetworking"
        let actualFrameworkName = sut.jNetworkingFrameworkName
        
        XCTAssertEqual(expectedFrameworkName, actualFrameworkName)
    }
}
