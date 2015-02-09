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
}
