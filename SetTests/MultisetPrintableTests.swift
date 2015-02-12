//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

final class MultisetPrintableTests: XCTestCase, Printable, DebugPrintable {
	func testDescription() {
		XCTAssertEqual(Multiset<Int>().description, "{}")
		XCTAssertEqual(Multiset(self).description, "{description}")
	}

	func testDebugDescription() {
		XCTAssertEqual(Multiset<Int>().debugDescription, "{}")
		XCTAssertEqual(Multiset(self).debugDescription, "{debugDescription}")
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
