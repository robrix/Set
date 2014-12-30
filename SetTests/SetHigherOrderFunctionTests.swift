//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetHigherOrderFunctionTests: XCTestCase {
	func testFilter() {
		XCTAssert(Set(1, 2, 3).filter { $0 == 2 } == Set(2))
	}

	func testReducible() {
		XCTAssert(Set(1, 2, 3).reduce(0, +) == 6)
	}

	func testMappable() {
		XCTAssert(Set(1, 2, 3).map(toString) == Set("1", "2", "3"))
	}

	func testFlatMapReturnsTheUnionOfAllResultingSets() {
		XCTAssert(Set(1, 2).flatMap { [$0, $0 * 2] } == Set(1, 2, 4))
	}
}
