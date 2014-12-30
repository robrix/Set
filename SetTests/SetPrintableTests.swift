//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetPrintableTests: XCTestCase {
	func testDescription() {
		XCTAssertEqual(Set<Int>().description, "{}")
		XCTAssertEqual(Set(1).description, "{1}")
	}

	func testDebugDescription() {
		XCTAssertEqual(Set<Int>().debugDescription, "{}")
		XCTAssertEqual(Set(1).debugDescription, "{1}")
	}
}
