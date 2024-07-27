import XCTest
@testable import JLocation

final class JLocationTests: XCTestCase {
    
    var sut: JLocation!
    
    override func setUp() {
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_frameworkName() throws {
        let expectedFrameworkName = "JLocation"
        let actualFrameworkName = sut.jLocationFrameworkName
        
        XCTAssertEqual(expectedFrameworkName, actualFrameworkName)
    }
}
