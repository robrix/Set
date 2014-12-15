//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetInitializerTests: XCTestCase {
	func testMinimumCapacity() {
		let set = Set<Int>(minimumCapacity: 4)
		XCTAssert(set.isEmpty)
	}
}
