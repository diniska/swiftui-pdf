import XCTest
@testable import SwiftUIPDF

@available(iOS 13.0, *)
final class SwiftUIPDFTests: XCTestCase {
    func testPDFPageViewLoadsLocalDocument() {
        guard let url = Bundle.module.url(forResource: "sample", withExtension: "pdf")
        else {
            XCTFail("Sample file not found")
            return
        }
        
        let view = PDFPageView(url: url)
        XCTAssertNotNil(view.page)
    }
    
    static let allTests = [
        ("PDFPageView loads local documnet", testPDFPageViewLoadsLocalDocument)
    ]
    
}
