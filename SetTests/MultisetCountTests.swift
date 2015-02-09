//  Copyright (c) 2015 Rob Rix. All rights reserved.

import Set
import XCTest

final class MultisetCountTests: XCTestCase {
	func testCountSumsElementsMultiplicities() {
		var multiset = Multiset<Int>()
		multiset.insert(0)
		multiset.insert(1)
		multiset.insert(1)
		XCTAssertEqual(multiset.count, 3)
	}
}
