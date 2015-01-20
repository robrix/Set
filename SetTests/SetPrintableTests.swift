//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetPrintableTests: XCTestCase, Printable, DebugPrintable {
	func testDescription() {
		XCTAssertEqual(Set<Int>().description, "{}")
		XCTAssertEqual(Set(self).description, "{description}")
	}

	func testDebugDescription() {
		XCTAssertEqual(Set<Int>().debugDescription, "{}")
		XCTAssertEqual(Set(self).debugDescription, "{debugDescription}")
	}


	// MARK: Printable

	override var description: String {
		return __FUNCTION__
	}


	// MARK: DebugPrintable

	override var debugDescription: String {
		return __FUNCTION__
	}
}
