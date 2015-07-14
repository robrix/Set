//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

final class TestElement: NSObject, CustomDebugStringConvertible {

	// MARK: CustomDebugStringConvertible

	override var debugDescription: String {
		return __FUNCTION__
	}
}

final class MultisetPrintableTests: XCTestCase {

	func testDebugDescription() {
		XCTAssertEqual(Multiset<Int>().debugDescription, "{}")
		XCTAssertEqual(Multiset(TestElement()).debugDescription, "{debugDescription}")
	}
	
}
