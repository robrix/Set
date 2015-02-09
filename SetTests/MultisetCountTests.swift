//  Copyright (c) 2015 Rob Rix. All rights reserved.

import Set
import XCTest

final class MultisetCountTests: XCTestCase {
	func testCountSumsElementsMultiplicities() {
		XCTAssertEqual(Multiset(0, 1, 1).count, 3)
	}

	func testCountOfAnElementIsItsMultiplicity() {
		XCTAssertEqual(Multiset(0, 1, 1).count(1), 2)
	}

	func testContainsIsTrueWhenCountIsGreaterThanZero() {
		XCTAssert(Multiset(0, 1, 1).contains(0))
		XCTAssert(Multiset(0, 1, 1).contains(1))
		XCTAssertFalse(Multiset(0, 1, 1).contains(2))
	}
}
